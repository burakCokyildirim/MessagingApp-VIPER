//
//  UIStoryboardExtensions.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 2.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static var Login: UIStoryboard {
        return UIStoryboard(name: "Login", bundle: nil)
    }
    
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static var tabBar: UIStoryboard {
        return UIStoryboard(name: "TabBar", bundle: nil)
    }
    
    static var sendLetter: UIStoryboard {
        return UIStoryboard(name: "SendLetter", bundle: nil)
    }
    
    static var Follow: UIStoryboard {
        return UIStoryboard(name: "Follow", bundle: nil)
    }
    
    func instantiateViewController<VC: UIViewController>() -> VC {
        guard let viewController = self.instantiateViewController(withIdentifier: VC.className) as? VC
        else { fatalError("could not instantiateViewController with identifier \(VC.className)") }
        return viewController
    }
}
