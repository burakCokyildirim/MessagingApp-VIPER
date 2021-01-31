//
//  SettingsTableViewController.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 6.05.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    
    // MARK: - Dependencies
    
    var viewController: SettingsTableToViewProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            viewController.profilePictureCellTapped()
        case 3:
            viewController.passwordCellTapped()
        case 4:
            viewController.logoutCellTapped()
        case 7:
            viewController.privacyPolicyCellTapped()
        case 8:
            viewController.termsAndConditionsCellTapped()
        case 9:
            viewController.aboutCellTapped()
        default:
            break
        }
    }

}

extension SettingsTableViewController: SettingsViewToTableProtocol {
    
    func setUserInfo(user: ProfileModel) {
        profilePicture.setImage(url: user.profilePicture)
        profilePicture.makeRounded()
        username.text = user.firstName + " " + user.lastName
        email.text = user.email
    }
}
