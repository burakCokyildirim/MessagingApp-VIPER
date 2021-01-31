//
//  RegisterProtocols.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 1.03.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim

import UIKit

// MARK: - View Controller

protocol RegisterViewControllerProtocol: BaseViewControllerProtocol {
    func completeRegister()
}

// MARK: - Presenter

protocol RegisterPresenterViewProtocol: BasePresenterViewProtocol {
    func fetchResgister(checkBoxStatus: Bool, name: String, email: String, password: String, confirmPassword: String)
}

protocol RegisterPresenterInteractorProtocol: BasePresenterInteractorProtocol {
    func completeRegister()
}

protocol RegisterPresenterDelegateProtocol: BasePresenterDelegateProtocol {
    
}

// MARK: - Interactor

protocol RegisterInteractorProtocol: BaseInteractorProtocol {
    func fetchResgister(name: String, surname: String, email: String, password: String)
}
