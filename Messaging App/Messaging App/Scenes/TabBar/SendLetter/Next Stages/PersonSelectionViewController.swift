//
//  PersonSelectionViewController.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 16.04.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim
//

import UIKit

class PersonSelectionViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var usernameText: CustomTextField!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Constraints

    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    
    // MARK: - Dependencies
    
    var presenter: SendLetterPresenterViewProtocol!
    
    // MARK: - Properties
    
    var matchingUsers: [PersonModel] = []
    var selectedUser: PersonModel?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Configure
    
    override func configureView() {
        super.configureView()
        
        dismissKeyboard(press: nil)
        
        barTitle = "who_will_send".localized
        
        tableView.layer.cornerRadius = 10
    }
    
    override func dismissKeyboard(press: UITapGestureRecognizer? = nil) {
        if let press = press {
            let location = press.location(in: view)
            if tableView.frame.contains(location) {
                return
            }
        }
        
        super.dismissKeyboard(press: nil)
    }
    
    // MARK: - Initialization
    
    // MARK: - Actions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.leftTapped()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        presenter.setUserAndNext(user: selectedUser)
    }
    
    @IBAction func inviteEmailButtonTapped(_ sender: Any) {
        let inveteMessage = "invete_message".localized
        
        if let url = createEmailUrl(inveteMessage) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func inviteWhatsappButtonTapped(_ sender: Any) {
        let inveteMessage = "invete_message".localized
        let escapedString = inveteMessage.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        if let url = URL(string: "whatsapp://send?text=\(escapedString!)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showPopup(title: "error".localized, message: "message_text.no_whatsapp".localized, completionHandler: nil)
            }
        }
    }
    
    @IBAction func usernameTextChanged(_ sender: CustomTextField) {
        guard let searchText = sender.text else { return }
        
        if searchText.count < 3 {
            tableViewHeightConstraint.constant = 0
            return
        }
        
        presenter.searchUsers(searchText: searchText)
    }
    
    // MARK: -
    
    func createEmailUrl(_ message: String) -> URL? {
        guard let inveteTitle = "Messaging App".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let inveteMessage = message.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            else { return nil }

        let to = ""
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(inveteTitle)&body=\(inveteMessage)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(inveteTitle)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(inveteTitle)&body=\(inveteMessage)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(inveteTitle)&body=\(inveteMessage)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(inveteTitle)&body=\(inveteMessage)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }

        return defaultUrl
    }
}

// MARK: - Extensions

extension PersonSelectionViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.matchingUsers.removeAll()
        tableView.reloadData()
        tableViewHeightConstraint.constant = CGFloat(50 * matchingUsers.count)
        viewTopConstraint.isActive = true
        usernameText.text = ""
        self.selectedUser = nil
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tableViewHeightConstraint.constant = 0
        viewTopConstraint.isActive = false
        if selectedUser == nil {
            usernameText.text = ""
        }
    }
}

extension PersonSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingUsers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        if let cell = cell as? PersonCell {
            let person = matchingUsers[indexPath.row]
            
            if person.userID == nil {
                cell.userName.text = "no_matches_found".localized
                cell.profilePicture.image = #imageLiteral(resourceName: "emptyPaper.png")
                cell.isUserInteractionEnabled = false
                return cell
            }
            
            cell.isUserInteractionEnabled = true
            
            if let imageUrl = person.profileUrl {
                if !imageUrl.isEmpty {
                    cell.profilePicture.setImage(url: imageUrl)
                    cell.profilePicture.makeRounded()
                } else {
                    cell.profilePicture.image = #imageLiteral(resourceName: "defaultProfilePicture.png")
                }
            }
            cell.userName.text = person.firstName + " " + person.lastName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = matchingUsers[indexPath.row]
        self.selectedUser = person
        usernameText.text = person.firstName + " " + person.lastName
        tableViewHeightConstraint.constant = 0
        dismissKeyboard()
    }
}

// MARK: - Protocol Implemantations

extension PersonSelectionViewController: PersonSelectViewControllerProtocol {
    
    func showMatchingUsers(result: [PersonModel]) {
        var result = result
        if result.count == 0 {
            result.append(PersonModel())
        }
        matchingUsers = result
        tableView.reloadData()
        tableViewHeightConstraint.constant = CGFloat(50 * matchingUsers.count)
    }
    
    func completeUserSelection() {
        let nextController: SelectSendTypeViewController = UIStoryboard.sendLetter.instantiateViewController()
        presenter.selectSendTypeViewController = nextController
        nextController.presenter = presenter
               
        navigationController?.pushViewController(nextController, animated: false)
    }
}
