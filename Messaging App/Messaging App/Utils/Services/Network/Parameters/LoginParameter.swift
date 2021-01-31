//
//  LoginParameter.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 6.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation

class LoginParameter: BaseParameter {
    
    var password: String!
    var email: String!
    
    override func toDictionary() -> [String : Any]? {
        return [
            "password": password as Any,
            "email": email as Any]
    }
}
