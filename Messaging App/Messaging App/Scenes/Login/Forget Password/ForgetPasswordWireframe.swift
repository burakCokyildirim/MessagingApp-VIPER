//
//  ForgetPasswordWireframe.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 8.03.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim

import UIKit

class ForgetPasswordWireframe: BaseWireframe {
    
    // TODO: Use tuples for extras if you have more than once parameters
    func show(transitionType: WireframeTransitionType, delegate: ForgetPasswordPresenterDelegateProtocol? = nil, extras: Any? = nil) {
        // TODO: Choose related storyboard
        let viewController: ForgetPasswordViewController = UIStoryboard.Login.instantiateViewController()
        
        // TODO: Inteactor Dependencies
        let interactor = ForgetPasswordInteractor(networkService: NetworkService.sharedInstance)
        
        let presenter = ForgetPasswordPresenter(viewController: viewController, interactor: interactor, delegate: delegate, extras: extras)
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        changeView(transationType: transitionType, viewController: viewController)
    }
    
}