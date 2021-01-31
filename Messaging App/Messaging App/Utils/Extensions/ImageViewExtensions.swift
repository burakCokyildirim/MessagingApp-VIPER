//
//  ImageViewExtensions.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 19.04.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(url: String) {
        kf.setImage(with: URL(string: url))
    }
    
    func makeRounded() {

        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
