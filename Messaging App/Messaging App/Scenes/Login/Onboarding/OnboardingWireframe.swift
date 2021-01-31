//
//  OnboardingWireframe.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 1.03.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim

import UIKit

class OnboardingWireframe: BaseWireframe {
    
    // TODO: Use tuples for extras if you have more than once parameters
    func show(transitionType: WireframeTransitionType, delegate: OnboardingPresenterDelegateProtocol? = nil, extras: Any? = nil) {
        // TODO: Choose related storyboard
        let viewController: OnboardingViewController = UIStoryboard.Login.instantiateViewController()
        
        // TODO: Inteactor Dependencies
        let interactor = OnboardingInteractor()
        
        let presenter = OnboardingPresenter(viewController: viewController, interactor: interactor, delegate: delegate, extras: extras)
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        changeView(transationType: transitionType, viewController: viewController)
    }
    
}