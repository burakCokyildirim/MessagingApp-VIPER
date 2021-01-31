//
//  UIViewControllerExtensions.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 4.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

extension UIViewController {
    func showPopup(title: String, message: String, completionHandler: PopupCompletionHandler?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok".localized, style: .default, handler: { (action) in
            completionHandler?(.done)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showPopupYesNo(title: String, message: String, completionHandler: PopupCompletionHandler?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "yes".localized, style: .default, handler: { (action) in
            completionHandler?(.yes)
        }))
        
        alert.addAction(UIAlertAction(title: "no".localized, style: .cancel, handler: { (action) in
            completionHandler?(.no)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
