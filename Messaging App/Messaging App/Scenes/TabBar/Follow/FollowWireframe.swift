//
//  FollowWireframe.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 11.04.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim

import UIKit

class FollowWireframe: BaseWireframe {
    
    func initializeTabBar(tabBarController: UITabBarController, tabBarItem: UITabBarItem, delegate: FollowPresenterDelegateProtocol? = nil, extras: Any? = nil) {
        let viewController: FollowViewController = UIStoryboard.tabBar.instantiateViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let interactor = FollowInteractor(networkService: NetworkService.sharedInstance)
        
        let presenter = FollowPresenter(viewController: viewController, interactor: interactor, delegate: nil, extras: nil)
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        navigationController.tabBarItem = tabBarItem
        tabBarController.addChild(navigationController)
    }
}
