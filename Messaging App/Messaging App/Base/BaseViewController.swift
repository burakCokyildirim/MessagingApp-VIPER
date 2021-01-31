//
//  BaseViewController.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 1.03.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController, NVActivityIndicatorViewable {
    
    lazy var keyWindow: UIWindow? = {
         if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        } else {
            return UIApplication.shared.keyWindow
        }
    }()
    
    lazy var loading: NVActivityIndicatorView = {
        let window = self.keyWindow!
        let loading = NVActivityIndicatorView(frame: CGRect.zero, type: .ballPulseSync, color: UIColor(red: 0.0, green: 167.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0), padding: 20)
        window.addSubview(loading)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        return loading
    }()
    
    lazy var loadingInView: NVActivityIndicatorView = {
        let loading = NVActivityIndicatorView(frame: CGRect.zero, type: .ballPulseSync, color: UIColor(red: 0.0, green: 167.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0), padding: 20)
        view.addSubview(loading)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return loading
    }()

    lazy var blockerView: UIView = {
        let window = self.keyWindow!
        let blocker = UIView(frame: window.frame)
        blocker.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return blocker
    }()
    
    var barTitle: String? {
        didSet {
            navigationItem.title = barTitle
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: - Configure
    
    func configureView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(press:)))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        
        self.updateNavigationBar()
    }
    
    func updateNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = #colorLiteral(red: 0.9341667891, green: 0.7201300263, blue: 0.5555436015, alpha: 1)
        navigationController?.navigationBar.layer.shadowOpacity = 1
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 0
        
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1945147812, green: 0.5996853709, blue: 0.9689573646, alpha: 1)
        
        navigationItem.hidesBackButton = true
        
        
        if navigationController?.viewControllers.count ?? 0 > 1 {
            setLeftNavigationBarItem(image: #imageLiteral(resourceName: "backButtonIcon.png"), action: #selector(leftButtonTapped))
        }
    }
    
    func setLeftNavigationBarItem(image: UIImage, action: Selector) {
        let leftButton = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
        navigationItem.setLeftBarButton(leftButton, animated: false)
    }
    
    @objc func leftButtonTapped() {
        leftTapped()
    }

    func setRightNavigationBarItem(image: UIImage, action: Selector) {
        let rightButton = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
        navigationItem.setRightBarButton(rightButton, animated: false)
    }
    
    @objc func showProfile() {
        if let navigationController = navigationController {
            SettingsWireframe().show(transitionType: .push(navigationController: navigationController, animated: false))
        } else {
            SettingsWireframe().show(transitionType: .present(fromViewController: self))
        }
    }
    
    // MARK: Navigation View Delegate
    
    func leftTapped() {
        navigationController?.popViewController(animated: false)
    }
    
    func rightTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Extensions

// MARK: - Protocol Implemantations

extension BaseViewController: BaseViewControllerProtocol {
    func showError(errorModel: ErrorModel, completionHandler: PopupCompletionHandler? = nil) {
        stopLoading()
        stopProgress()
        unlockUI()
        showPopup(title: errorModel.errorType.localized, message: errorModel.errorMessage, completionHandler: completionHandler)
    }
    
    func showValidationError(errorMessage: String) {
        let error = ErrorModel(genericErrorType: .validation, errorMessage: errorMessage)
        showError(errorModel: error)
    }
    
    func showReachability(errorModel: ErrorModel, completionHandler: PopupCompletionHandler? = nil) {
        unlockUI()
        stopProgress()
        showPopup(title: errorModel.errorType.localized, message: errorModel.errorMessage) { (closeType) in
            if closeType == .done {
                self.showSplash()
            }
        }
    }
    
    func showSplash() {
        SplashWireframe().show(transitionType: .root)
    }
    
    func showTokenExpireMessage(errorModel: ErrorModel) {
        unlockUI()
        stopProgress()
        showPopup(title: errorModel.errorType.localized, message: errorModel.errorMessage) { (closeType) in
            if closeType == .done {
                self.showSplash()
            }
        }
    }
    
    func lockUI() {
        navigationController?.navigationBar.isUserInteractionEnabled = false
        navigationController?.view.isUserInteractionEnabled = false
    }
    
    func unlockUI() {
        navigationController?.navigationBar.isUserInteractionEnabled = true
        navigationController?.view.isUserInteractionEnabled = true
    }
    
    @objc func startProgress() {
        let window = self.keyWindow!
        window.addSubview(blockerView)
        loading.startAnimating()
        window.bringSubviewToFront(loading)
        self.view.isUserInteractionEnabled = false
    }
    
    @objc func stopProgress() {
        blockerView.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
        loading.stopAnimating()
    }
    
    @objc func startLoading() {
        if !loading.isAnimating { loading.startAnimating() }
    }
    
    @objc func stopLoading() {
        loading.stopAnimating()
    }
    
    @objc func startProgressInView() {
        view.addSubview(blockerView)
        loadingInView.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    @objc func stopProgressInView() {
        blockerView.removeFromSuperview()
        view.isUserInteractionEnabled = true
        loadingInView.stopAnimating()
    }
    
    @objc func startLoadingInView() {
        if !loadingInView.isAnimating { loadingInView.startAnimating() }
    }
    
    @objc func stopLoadingInView() {
        loadingInView.stopAnimating()
    }
    
    @objc func dismissKeyboard(press: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
}