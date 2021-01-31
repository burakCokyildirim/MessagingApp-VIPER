//
//  LoginPresenter.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 1.03.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim
//

import Foundation

class LoginPresenter: BasePresenter {
    
    // MARK: - Dependencies
    
    fileprivate var viewController: LoginViewControllerProtocol!
    fileprivate var interactor: LoginInteractorProtocol!
    fileprivate var delegate: LoginPresenterDelegateProtocol?
    
    // MARK: - Extras
    
    // MARK: - Properties
    
    var email: String = ""
    var password: String = ""
    
    // MARK: - Initialization
    
    init(viewController: LoginViewControllerProtocol, interactor: LoginInteractorProtocol, delegate: LoginPresenterDelegateProtocol?, extras: Any?) {
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

extension LoginPresenter: LoginPresenterViewProtocol {
    
    func fetchLogin(email: String, password: String) {
        if email.count == 0 {
            viewController.showValidationError(errorMessage:
                "warning_empty_email".localized)
            return
        }
        
        if password.count == 0 {
            viewController.showValidationError(errorMessage:
                "warning_empty_password".localized)
            return
        }
        
        if !email.isValidEmail {
            viewController.showValidationError(errorMessage:
                "warning_wrong_email".localized)
            return
        }
        
        self.email = email
        self.password = password
        
        viewController.startProgress()
        interactor.fetchLogin(email: email, password: password)
    }
}

// MARK: Interactor Protocol

extension LoginPresenter: LoginPresenterInteractorProtocol {
    
    func presentHomePage() {
        
        viewController.stopProgress()
        viewController.navigateHomePage()
    }

    func presentConfirmationCode(state: ConfirmationViewState) {
        
        viewController.stopProgress()
        viewController.navigateConfirmationCode(state: state)
    }
}

// MARK: Delegate Protocol

