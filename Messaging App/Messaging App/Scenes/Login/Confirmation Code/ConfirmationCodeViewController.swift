//
//  ConfirmationCodeViewController.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 8.03.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim
//

import UIKit
import PhoneNumberKit

class ConfirmationCodeViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var phoneNumberText: PhoneNumberTextField!
    @IBOutlet weak var pinText: UITextField!
    @IBOutlet weak var addressText: CustomTextField!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var sendAgainButton: UIButton!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - Dependencies
    
    var presenter: ConfirmationCodePresenterViewProtocol!
    
    // MARK: - Properties
    
    static let remainingTimeValue = 120
    
    var address: AddressModel?
    var activeTextField: UITextField!
    var startTime: Date!
    let codeFieldLimit = 5
    var timer: Timer?
    var remainingTimeDuration = ConfirmationCodeViewController.remainingTimeValue
    
    var viewState: ConfirmationViewState = .step1 {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    // MARK: - Configure
    
    override func configureView() {
        super.configureView()
        
        presenter.setConfirmationVeriables()
        viewState = presenter.state
        phoneNumberText.withFlag = true
        phoneNumberText.withExamplePlaceholder = true
        phoneNumberText.withPrefix = true
        phoneNumberText.withDefaultPickerUI = true
    }
    
    func updateView() {
        switch viewState {
        case .step1:
            phoneNumberText.isHidden = false
            pinText.isHidden = true
            remainingTimeLabel.isHidden = true
            sendAgainButton.isHidden = true
            addressText.isHidden = true
            headerLabel.text = "confirmation_code.enter_phone_number".localized
            bodyLabel.text = "confirmation_code.verify_text".localized
            backButton.isHidden = true
            break
        case .step2:
            phoneNumberText.isHidden = true
            pinText.isHidden = false
            remainingTimeLabel.isHidden = false
            sendAgainButton.isHidden = false
            addressText.isHidden = true
            headerLabel.text = "confirmation_code.verify_phone_number".localized
            bodyLabel.text = presenter.bodyLabelText
            backButton.isHidden = false
            break
        case .step3:
            phoneNumberText.isHidden = true
            pinText.isHidden = true
            remainingTimeLabel.isHidden = true
            addressText.isHidden = false
            headerLabel.text = "confirmation_code.enter_address_information".localized
            bodyLabel.text = "confirmation_code.address_text".localized
            sendAgainButton.isHidden = true
            backButton.isHidden = true
            break
        }
    }
    
    // MARK: - Initialization
    
    func startTimer() {
        stopTimer()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: false)
        RunLoop.current.add(timer!, forMode: .default)
    }
    
    func stopTimer() {
        if let timer = timer {
            timer.invalidate()
        }
        timer = nil
    }
    
    @objc func updateTimer() {
        if remainingTimeDuration > 0 {
            startTimer()
            
            remainingTimeDuration -= 1
            updateRemainingTime()
            
            if remainingTimeDuration == 0 {
                sendAgainButton.isEnabled = true
                stopTimer()
            }
        }
    }
    
    func updateRemainingTime() {
        if remainingTimeDuration <= 0 {
            remainingTimeLabel.isHidden = true
            remainingTimeLabel.text = ""
        } else {
            remainingTimeLabel.isHidden = false
            remainingTimeLabel.text = "(\(remainingTimeDuration))"
        }
    }
    
    // MARK: - Actions
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        switch viewState {
        case .step1:
            if !phoneNumberText.isValidNumber {
                showError(errorModel: ErrorModel(genericErrorType: .invalidPhoneNumber))
                return
            }
            
            guard let phoneNumber = phoneNumberText.phoneNumber?.adjustedNationalNumber() else { return }
            
            guard let countryCode = phoneNumberText.phoneNumber?.countryCode else { return }
            
            presenter.state = .step2(phoneNumber: phoneNumber, countryCode: countryCode)
        case .step2:
            guard let code = pinText.text else { return }
            
            presenter.state = .step3
            presenter.confirmCode(confirmationCode: code)
        case .step3:
            guard let address = self.address else {
                showError(errorModel: Errors.notSelectedAddress, completionHandler: nil)
                return
            }
            
            presenter.updateAddressInformation(address: address)
        }
    }
    
    @IBAction func sendAgainButtonTapped(_ sender: Any) {
        presenter.sendVerificationCode()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        switch viewState {
        case .step2:
            presenter.state = .step1
            viewState = .step1
            stopTimer()
            remainingTimeLabel.text = ""
        default:
            break
        }
    }
}

// MARK: - Extensions

extension ConfirmationCodeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField == phoneNumberText) {
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)

            let decimalString = components.joined(separator: "") as NSString
            let length = decimalString.length
            let hasLeadingOne = length > 0 && decimalString.hasPrefix("1")

            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11 {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int

                return (newLength > 10) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()

            if hasLeadingOne {
                formattedString.append("1 ")
                index += 1
            }
            if (length - index) > 3 {
                let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("(%@)", areaCode)
                index += 3
            }
            if length - index > 3 {
                let prefix = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }

            let remainder = decimalString.substring(from: index)
            formattedString.append(remainder)
            textField.text = formattedString as String
            return false
        } else if textField == pinText {
            if !string.containsOnlyCharactersIn(matchCharacters: "0123456789") {
                return false
            }
            
            switch textField {
            case pinText:
                if NSString(string: textField.text!).replacingCharacters(in: range, with: string).count == codeFieldLimit {
                    textField.text = textField.text! + string
                    dismissKeyboard()
                }
                if ((textField.text?.count)! + (string.count - range.length)) > codeFieldLimit {
                    return false
                }
            default:
                return true
            }
            return true
        }
        else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
        if textField == addressText {
            DispatchQueue.main.async {
                self.dismissKeyboard(press: nil)
                let mapViewController: MapViewController = UIStoryboard.Login.instantiateViewController()
                mapViewController.confirmationCodeView = self
                BaseWireframe().changeView(transationType: .present(fromViewController: self), viewController: mapViewController)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Protocol Implemantations

extension ConfirmationCodeViewController: ConfirmationCodeViewControllerProtocol {
    
    func showVerification() {
        remainingTimeDuration = ConfirmationCodeViewController.remainingTimeValue
        startTime = Date()
        DispatchQueue.main.async {
            self.viewState = self.presenter.state
            self.sendAgainButton.isEnabled = false
        }
        startTimer()
    }
    
    func showAddressSelection() {
        stopTimer()
        
        DispatchQueue.main.async {
            self.viewState = self.presenter.state
        }
    }
    
    func goToHomeScreen() {
        let tabBarController: MainTabBarController = UIStoryboard.main.instantiateViewController()
        BaseWireframe().changeView(transationType: .root, viewController: tabBarController)
    }
    
    func complateAddressSelection(address: AddressModel) {
        self.address = address
        addressText.text = address.description
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if (notification.name == UIResponder.keyboardWillShowNotification ||
            notification.name == UIResponder.keyboardWillChangeFrameNotification) && activeTextField == phoneNumberText {
        
            let addressTextY = addressText.frame.origin.y
            let keyboardY = keyboardRect.origin.y
            
            if addressTextY < keyboardY {
                self.view.frame.origin.y -= ((keyboardY + 25) - addressTextY)
            }
            
        } else {
            self.view.frame.origin.y = 0
        }
    }
}

extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}
