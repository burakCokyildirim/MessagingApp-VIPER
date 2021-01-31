//
//  ForgetPasswordInteractor.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 8.03.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim

import Foundation

class ForgetPasswordInteractor: BaseInteractor {
    
    // MARK: - Dependencies
    
    var presenter: ForgetPasswordPresenterInteractorProtocol!
    
    // MARK: - Initialization
    
    override init(networkService: NetworkService? = nil, coreDataService: CoreDataService? = nil) {
        super.init(networkService: networkService, coreDataService: coreDataService)
    }
    
    // MARK: - Business Logic

}

// MARK: - Extensions

// MARK: - Protocols Implemantations

extension ForgetPasswordInteractor: ForgetPasswordInteractorProtocol {
    func sendRequest(email: String) {
        let paramters: [String: Any] = ["email": email as Any]
        let header = NetworkConstants.contentType
        
        networkService.postJSON(url: NetworkConstants.forgotPassword, parameters: paramters, headers: header, success: { (json) in
            guard let statusCode = json["statusCode"].int else {
                self.presenter.handleAndShowError(errorModel: ErrorModel.default)
                return
            }
            
            //statusCode => 0: Success, 1: EmailNotExist
            switch statusCode {
            case 0:
                self.presenter.presentSuccess()
            case 1:
                self.presenter.handleAndShowError(errorModel: Errors.emailNotExist)
            default:
                self.presenter.handleAndShowError(errorModel: Errors.somethingsWrong)
            }
        }) { (errorModel) in
            self.presenter.handleAndShowError(errorModel: errorModel)
        }
    }
}
