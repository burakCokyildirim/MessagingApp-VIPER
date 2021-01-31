//
//  ProfileModel.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 6.05.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProfileModel: BaseModel {
    var userID: String!
    var firstName: String!
    var lastName: String!
    var email: String!
    var phoneNumber: String!
    var addressDesc: String!
    var profilePicture: String!
    
    required init(json: JSON) {
        super.init(json: json)
        
        userID = json["user"]["Id"].stringValue
        firstName = json["user"]["FirstName"].stringValue
        lastName = json["user"]["LastName"].stringValue
        addressDesc = json["user"]["addressDescription"].stringValue
        profilePicture = json["user"]["ProfilePicture"].stringValue
        phoneNumber = json["user"]["PhoneNumber"].stringValue
        email = json["user"]["email"].stringValue
    }
}
