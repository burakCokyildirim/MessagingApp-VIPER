//
//  FollowPresenter.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 11.04.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim
//

import Foundation

class FollowPresenter: BasePresenter {
    
    // MARK: - Dependencies
    
    fileprivate var viewController: FollowViewControllerProtocol!
    fileprivate var interactor: FollowInteractorProtocol!
    fileprivate var delegate: FollowPresenterDelegateProtocol?
    
    // MARK: - Extras
    
    // MARK: - Properties
    
    // MARK: - Initialization
    
    init(viewController: FollowViewControllerProtocol, interactor: FollowInteractorProtocol, delegate: FollowPresenterDelegateProtocol?, extras: Any?) {
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

extension FollowPresenter: FollowPresenterViewProtocol {
    
}

// MARK: Interactor Protocol

extension FollowPresenter: FollowPresenterInteractorProtocol {
    
}

// MARK: Delegate Protocol

