//
//  IncomingWireframe.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 11.04.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim

import UIKit

class IncomingWireframe: BaseWireframe {
    
    func initializeTabBar(tabBarController: UITabBarController, tabBarItem: UITabBarItem, delegate: IncomingPresenterDelegateProtocol? = nil, extras: Any? = nil) {
        let viewController: IncomingViewController = UIStoryboard.tabBar.instantiateViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let interactor = IncomingInteractor(networkService: NetworkService.sharedInstance)
        
        let presenter = IncomingPresenter(viewController: viewController, interactor: interactor, delegate: nil, extras: nil)
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        navigationController.tabBarItem = tabBarItem
        tabBarController.addChild(navigationController)
    }
}
