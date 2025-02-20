//
//  BaseWireframe.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 1.03.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim

import UIKit

enum WireframeTransitionType {
    case root
    case present(fromViewController: UIViewController)
    case push(navigationController: UINavigationController, animated: Bool = true)
}

class BaseWireframe {
    
    internal func changeView(transationType: WireframeTransitionType, viewController: UIViewController) {
        switch transationType {
        case .root:
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.first?.rootViewController = viewController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            } else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = viewController
                
                appDelegate.window?.makeKeyAndVisible()
            }
        case .present(let fromViewController):
            fromViewController.present(viewController, animated: true, completion: nil)
        case .push(let navigationController, let animated):
            navigationController.pushViewController(viewController, animated: animated)
        }
    }
}
