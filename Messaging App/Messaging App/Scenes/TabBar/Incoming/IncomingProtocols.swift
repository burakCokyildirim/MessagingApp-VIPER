//
//  IncomingProtocols.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 11.04.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim

import UIKit

// MARK: - View Controller

protocol IncomingViewControllerProtocol: BaseViewControllerProtocol {
    func showLetters(_ letters: [LetterModel], _ incomingCount: Int, _ outgoingCount: Int)
    func notifyBlockSuccess()
    func notifyReportSuccess()
}

// MARK: - Presenter

protocol IncomingPresenterViewProtocol: BasePresenterViewProtocol {
    func fetchLetters()
    func blockUser(letterId: String)
    func reportUser(letterId: String)
}

protocol IncomingPresenterInteractorProtocol: BasePresenterInteractorProtocol {
    func presentLetters(_ letters: [LetterModel], _ incomingCount: Int, _ outgoingCount: Int)
    func notifyBlockSuccess()
    func notifyReportSuccess()
}

protocol IncomingPresenterDelegateProtocol: BasePresenterDelegateProtocol {
    
}

// MARK: - Interactor

protocol IncomingInteractorProtocol: BaseInteractorProtocol {
    func fetchLetters()
    func blockUser(letterId: String)
    func reportUser(letterId: String)
}
