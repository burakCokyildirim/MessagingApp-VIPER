//
//  ConfirmationCodeParameter.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 11.04.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation

class ConfirmationCodeParameter: BaseParameter {
    
    var phone: String!
    var code: String!
    
    
    override func toDictionary() -> [String : Any]? {
        return [
            "phone": phone as Any,
            "code": code as Any]
    }
}
