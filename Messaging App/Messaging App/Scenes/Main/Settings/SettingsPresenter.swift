//
//  SettingsPresenter.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 15.04.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim
//

import UIKit

class SettingsPresenter: BasePresenter {
    
    // MARK: - Dependencies
    
    fileprivate var viewController: SettingsViewControllerProtocol!
    fileprivate var interactor: SettingsInteractorProtocol!
    fileprivate var delegate: SettingsPresenterDelegateProtocol?
    
    // MARK: - Extras
    
    // MARK: - Properties
    
    // MARK: - Initialization
    
    init(viewController: SettingsViewControllerProtocol, interactor: SettingsInteractorProtocol, delegate: SettingsPresenterDelegateProtocol?, extras: Any?) {
        self.viewController = viewController
        self.interactor = interactor
        self.delegate = delegate
        
        // Store extras
    }
    
    // MARK: - Business Logic
    
    // MARK: - Override
    
    override func handleAndShowError(errorModel: ErrorModel) {
        viewController.stopProgress()
        if handleError(errorModel: errorModel, viewController: viewController) {
            viewController.showError(errorModel: errorModel)
        }
    }
}

// MARK: - Extensions

// MARK: - Protocols Implemantations

// MARK: View Protocol

extension SettingsPresenter: SettingsPresenterViewProtocol {
    
    func fetchProfile() {
        viewController.startLoading()
        DispatchQueue.global().async {
            self.interactor.fetchProfile()
        }
    }
    
    func logout() {
        viewController.startProgress()
        interactor.logout()
    }
    
    func uploadPicture(_ imageData: Data) {
        viewController.startProgress()
        interactor.uploadPicture(imageData)
    }
    
    func changePassword(_ oldPassword: String, _ newPassword: String, _ confirmPassword: String, _ view: UIView) {
        
        if oldPassword.count == 0 || newPassword.count == 0 || confirmPassword.count == 0 {
            viewController.showValidationError(errorMessage:
                "warning_empty_areas".localized)
            return
        }
        
        if newPassword != confirmPassword {
            viewController.showValidationError(errorMessage:
                "warning_notmatch_passwords".localized)
            return
        }
        
        if oldPassword != newPassword {
            viewController.showValidationError(errorMessage:
                "warning_is_old_passwords".localized)
            return
        }
        
        if newPassword.count <= 6 {
            viewController.showValidationError(errorMessage:
                "warning_short_password".localized)
            return
        }
        
        viewController.startProgress()
        interactor.changePassword(oldPassword, newPassword, view)
    }
}

// MARK: Interactor Protocol

extension SettingsPresenter: SettingsPresenterInteractorProtocol {
    
    func showProfile(_ user: ProfileModel) {
        DispatchQueue.main.async {
            self.viewController.stopLoading()
            self.viewController.showProfile(user)
        }
    }
    
    func presentLogin() {
        viewController.stopProgress()
        viewController.showLogin()
    }
    
    func reloadView() {
        viewController.stopProgress()
        fetchProfile()
    }
    
    func dissmissChangePasswordView(_ view: UIView) {
        viewController.stopProgress()
        viewController.dissmissChangePasswordView(view)
    }
}

// MARK: Delegate Protocol

