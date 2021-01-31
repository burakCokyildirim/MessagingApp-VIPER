//
//  NSObjectExtension.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 2.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation

extension NSObject {

    class var className: String {
        return String(describing: self)
    }
}
