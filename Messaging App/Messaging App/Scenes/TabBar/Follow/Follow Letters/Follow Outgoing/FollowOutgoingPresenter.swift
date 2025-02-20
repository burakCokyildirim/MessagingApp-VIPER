//
//  FollowOutgoingPresenter.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 4.05.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim
//

import Foundation

class FollowOutgoingPresenter: BasePresenter {
    
    // MARK: - Dependencies
    
    fileprivate var viewController: FollowOutgoingViewControllerProtocol!
    fileprivate var interactor: FollowOutgoingInteractorProtocol!
    fileprivate var delegate: FollowOutgoingPresenterDelegateProtocol?
    
    // MARK: - Extras
    
    // MARK: - Properties
    
    // MARK: - Initialization
    
    init(viewController: FollowOutgoingViewControllerProtocol, interactor: FollowOutgoingInteractorProtocol, delegate: FollowOutgoingPresenterDelegateProtocol?, extras: Any?) {
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

extension FollowOutgoingPresenter: FollowOutgoingPresenterViewProtocol {
    
    func fetchLetters() {
        viewController.startLoading()
        interactor.fetchLetters()
    }
    
    func revertLetter(_ letterID: Int) {
        viewController.startProgress()
        interactor.revertLetter(letterID)
    }
}

// MARK: Interactor Protocol

extension FollowOutgoingPresenter: FollowOutgoingPresenterInteractorProtocol {
    
    func presentLetters(_ letters: [LetterModel]) {
        viewController.stopLoading()
        viewController.showLetters(letters)
    }
    
    func refreshLetters() {
        viewController.stopProgress()
        interactor.fetchLetters()
    }
}

// MARK: Delegate Protocol

