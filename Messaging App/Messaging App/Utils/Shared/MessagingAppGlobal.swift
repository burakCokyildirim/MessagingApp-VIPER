//
//  MessagingAppGlobal.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 7.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation

class MessagingAppGlobal {
    
    static let shared = MessagingAppGlobal()
    
    var userModel: UserModel?
    
    private init() { }
}
