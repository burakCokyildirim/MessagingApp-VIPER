//
//  UserModel.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 7.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation
import SwiftyJSON
import Kingfisher

class UserModel: BaseModel {
    
    var userID: String!
    var firstName: String!
    var lastName: String!
    var address: AddressModel!
    var profilePicture: String!
    
    required init(json: JSON) {
        super.init(json: json)
        
        userID = json["userID"].stringValue
        firstName = json["firstname"].stringValue
        lastName = json["lastname"].stringValue
        address = AddressModel(json: json["address"])
        profilePicture = json["profilePicture"].stringValue
    }
}
