//
//  SplashPresenter.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 1.03.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim
//

import Foundation

class SplashPresenter: BasePresenter {
    
    // MARK: - Dependencies
    
    fileprivate var viewController: SplashViewControllerProtocol!
    fileprivate var interactor: SplashInteractorProtocol!
    fileprivate var delegate: SplashPresenterDelegateProtocol?
    
    // MARK: - Extras
    
    // MARK: - Properties
    
    // MARK: - Initialization
    
    init(viewController: SplashViewControllerProtocol, interactor: SplashInteractorProtocol, delegate: SplashPresenterDelegateProtocol?, extras: Any?) {
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

extension SplashPresenter: SplashPresenterViewProtocol {
    
}

// MARK: Interactor Protocol

extension SplashPresenter: SplashPresenterInteractorProtocol {
    
}

// MARK: Delegate Protocol

