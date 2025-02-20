//
//  SettingsProtocols.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 15.04.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim

import UIKit

// MARK: - View Controller

protocol SettingsViewControllerProtocol: BaseViewControllerProtocol {
    func showProfile(_ user: ProfileModel)
    func showLogin()
    func dissmissChangePasswordView(_ view: UIView)
}

// MARK: - Presenter

protocol SettingsPresenterViewProtocol: BasePresenterViewProtocol {
    func fetchProfile()
    func logout()
    func uploadPicture(_ imageData: Data)
    func changePassword(_ oldPassword: String, _ newPassword: String, _ confirmPassword: String, _ view: UIView)
}

protocol SettingsPresenterInteractorProtocol: BasePresenterInteractorProtocol {
    func showProfile(_ user: ProfileModel)
    func presentLogin()
    func reloadView()
    func dissmissChangePasswordView(_ view: UIView)
}

protocol SettingsPresenterDelegateProtocol: BasePresenterDelegateProtocol {
    
}

// MARK: - Interactor

protocol SettingsInteractorProtocol: BaseInteractorProtocol {
    func fetchProfile()
    func logout()
    func uploadPicture(_ imageData: Data)
    func changePassword(_ oldPassword: String, _ newPassword: String, _ view: UIView)
}

// MARK: TableView Controller

protocol SettingsViewToTableProtocol {
    func setUserInfo(user: ProfileModel)
}

protocol SettingsTableToViewProtocol {
    func profilePictureCellTapped()
    func passwordCellTapped()
    func logoutCellTapped()
    func privacyPolicyCellTapped()
    func termsAndConditionsCellTapped()
    func aboutCellTapped()
}
