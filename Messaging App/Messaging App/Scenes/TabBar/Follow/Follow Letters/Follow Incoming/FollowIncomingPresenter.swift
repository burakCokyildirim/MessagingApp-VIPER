//
//  FollowIncomingPresenter.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 4.05.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim
//

import Foundation

class FollowIncomingPresenter: BasePresenter {
    
    // MARK: - Dependencies
    
    fileprivate var viewController: FollowIncomingViewControllerProtocol!
    fileprivate var interactor: FollowIncomingInteractorProtocol!
    fileprivate var delegate: FollowIncomingPresenterDelegateProtocol?
    
    // MARK: - Extras
    
    // MARK: - Properties
    
    // MARK: - Initialization
    
    init(viewController: FollowIncomingViewControllerProtocol, interactor: FollowIncomingInteractorProtocol, delegate: FollowIncomingPresenterDelegateProtocol?, extras: Any?) {
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

extension FollowIncomingPresenter: FollowIncomingPresenterViewProtocol {
    
    func fetchLetters() {
        viewController.startLoading()
        interactor.fetchLetters()
    }
}

// MARK: Interactor Protocol

extension FollowIncomingPresenter: FollowIncomingPresenterInteractorProtocol {
    
    func presentLetters(_ letters: [LetterModel]) {
        viewController.stopLoading()
        viewController.showLetters(letters)
    }
}

// MARK: Delegate Protocol

