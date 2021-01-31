//
//  TabBarController.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 8.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate, MiddleButtonDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var curvedTabBar: CurvedTabBar!
    
    // MARK: - Properties
    
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    var middleButton: UIButton?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        initializeTabBarItems()
        
        if let tabBar = tabBar as? CurvedTabBar {
            tabBar.middleButtonDelegate = self
        }
    }
    
    // MARK: - Initialization
    
    fileprivate func initializeTabBarItems() {
        let homeTabBarItem = UITabBarItem(title: "tab-bar.home".localized, image: #imageLiteral(resourceName: "tabBarHomeIcon"), selectedImage: nil)
        let incomingTabBarItem = UITabBarItem(title: "tab-bar.incoming".localized, image: #imageLiteral(resourceName: "tabBarIncomingIcon"), selectedImage: nil)
        let sendLetterTabBarItem = UITabBarItem()
        let outgoingTabBarItem = UITabBarItem(title: "tab-bar.outgoing".localized, image: #imageLiteral(resourceName: "tabBarOutgoingIcon"), selectedImage: nil)
        let followTabBarItem = UITabBarItem(title: "tab-bar.follow".localized, image: #imageLiteral(resourceName: "tabBarFollowIcon"), selectedImage: nil)
        
        HomeWireframe().initializeTabBar(tabBarController: self, tabBarItem: homeTabBarItem)
        IncomingWireframe().initializeTabBar(tabBarController: self, tabBarItem: incomingTabBarItem)
        SendLetterWireframe().initializeTabBar(tabBarController: self, tabBarItem: sendLetterTabBarItem)
        OutgoingWireframe().initializeTabBar(tabBarController: self, tabBarItem: outgoingTabBarItem)
        FollowWireframe().initializeTabBar(tabBarController: self, tabBarItem: followTabBarItem)
    }
    
    func middleButtonTapped() {
        self.selectedIndex = 2
    }
}
