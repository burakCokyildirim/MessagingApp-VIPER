//
//  LoginProtocols.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 1.03.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim

import UIKit

// MARK: - View Controller

protocol LoginViewControllerProtocol: BaseViewControllerProtocol {
    func navigateConfirmationCode(state: ConfirmationViewState)
    func navigateHomePage()
}

// MARK: - Presenter

protocol LoginPresenterViewProtocol: BasePresenterViewProtocol {
    func fetchLogin(email: String, password: String)
}

protocol LoginPresenterInteractorProtocol: BasePresenterInteractorProtocol {
    func presentConfirmationCode(state: ConfirmationViewState)
    func presentHomePage()
}

protocol LoginPresenterDelegateProtocol: BasePresenterDelegateProtocol {
    
}

// MARK: - Interactor

protocol LoginInteractorProtocol: BaseInteractorProtocol {
    func fetchLogin(email: String, password: String)
}