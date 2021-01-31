//
//  HomePresenter.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 11.04.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim
//

import Foundation

class HomePresenter: BasePresenter {
    
    // MARK: - Dependencies
    
    fileprivate var viewController: HomeViewControllerProtocol!
    fileprivate var interactor: HomeInteractorProtocol!
    fileprivate var delegate: HomePresenterDelegateProtocol?
    
    // MARK: - Extras
    
    // MARK: - Properties
    
    // MARK: - Initialization
    
    init(viewController: HomeViewControllerProtocol, interactor: HomeInteractorProtocol, delegate: HomePresenterDelegateProtocol?, extras: Any?) {
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

extension HomePresenter: HomePresenterViewProtocol {
    
    func getWillComingLetters() {
        viewController.startLoading()
        interactor.callWillComingLetters()
    }
}

// MARK: Interactor Protocol

extension HomePresenter: HomePresenterInteractorProtocol {
    
    func presentLetters(letters: [LetterModel]) {
        viewController.stopLoading()
        viewController.showWillComingLetters(letters: letters)
    }
}

// MARK: Delegate Protocol

