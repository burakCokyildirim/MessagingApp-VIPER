//
//  OnboardingPresenter.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 1.03.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim
//

import Foundation

class OnboardingPresenter: BasePresenter {
    
    // MARK: - Dependencies
    
    fileprivate var viewController: OnboardingViewControllerProtocol!
    fileprivate var interactor: OnboardingInteractorProtocol!
    fileprivate var delegate: OnboardingPresenterDelegateProtocol?
    
    // MARK: - Extras
    
    // MARK: - Properties
    
    // MARK: - Initialization
    
    init(viewController: OnboardingViewControllerProtocol, interactor: OnboardingInteractorProtocol, delegate: OnboardingPresenterDelegateProtocol?, extras: Any?) {
        self.viewController = viewController
        self.interactor = interactor
        self.delegate = delegate
        
        // Store extras
    }
    
    // MARK: - Business Logic
    
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

extension OnboardingPresenter: OnboardingPresenterViewProtocol {
    
}

// MARK: Interactor Protocol

extension OnboardingPresenter: OnboardingPresenterInteractorProtocol {
    
}

// MARK: Delegate Protocol

