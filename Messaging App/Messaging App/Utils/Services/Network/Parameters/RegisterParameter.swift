//
//  RegisterParameter.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 14.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation

class RegisterParameter: BaseParameter {
    
    var firstName: String!
    var lastName: String!
    var email: String!
    var phone: String!
    var addressDescription: String!
    var lat: String!
    var lng: String!
    var password: String!
    var confirmPassword: String!
    
    
    override func toDictionary() -> [String : Any]? {
        return [
            "firstName": firstName as Any,
            "lastName": lastName as Any,
            "email": email as Any,
            "phone": phone as Any,
            "addressDescription": addressDescription as Any,
            "lat": lat as Any,
            "lng": lng as Any,
            "password": password as Any,
            "confirmPassword": confirmPassword as Any]
    }
}
