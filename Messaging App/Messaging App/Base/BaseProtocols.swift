//
//  BaseProtocols.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 1.03.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim

import UIKit

// MARK: - View Controller

protocol BaseViewControllerProtocol: class {
    
    func showError(errorModel: ErrorModel, completionHandler: PopupCompletionHandler?)
    func showValidationError(errorMessage: String)
    func showReachability(errorModel: ErrorModel, completionHandler: PopupCompletionHandler?)
    func showSplash()
    func showTokenExpireMessage(errorModel: ErrorModel)
    func reloadTableView()
    func startProgress()
    func stopProgress()
    func startLoading()
    func stopLoading()
    func startLoadingInView()
    func lockUI()
    func unlockUI()
    func dismissKeyboard(press: UITapGestureRecognizer?)
}

// MARK: - Presenter

protocol BasePresenterViewProtocol: class {
    
}

protocol BasePresenterInteractorProtocol: class {
    
    func handleAndShowError(errorModel: ErrorModel)
    
}

protocol BasePresenterDelegateProtocol: class {
    
}

// MARK: - Interactor

protocol BaseInteractorProtocol: class {
    
}

// MARK: - Extensions

// MARK: View Controller

extension BaseViewControllerProtocol {
    
    func showError(errorModel: ErrorModel, completionHandler: PopupCompletionHandler? = nil) { }
    func showValidationError(errorMessage: String) { }
    func showTokenExpireMessage(errorModel: ErrorModel, completionHandler: PopupCompletionHandler? = nil) { }
    func showReachability(errorModel: ErrorModel) { }
    func showSplash() { }
    func reloadTableView() { }
    func startProgress() { }
    func stopProgress() { }
    func startLoading() { }
    func stopLoading() { }
    func startLoadingInView() { }
    func disableNavigationInteraction() {}
    func activateNavigationInteraction() {}
    func stopLoadingInView() { }
    func lockUI() { }
    func unlockUI() { }
}

// MARK: Presenter

extension BasePresenterViewProtocol {
    
}

extension BasePresenterInteractorProtocol {
        
}

extension BasePresenterDelegateProtocol {
    
}

// MARK: Interactor

extension BaseInteractorProtocol {
    
}
