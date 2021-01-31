//
//  PersonModel.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 19.04.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation
import SwiftyJSON

class PersonModel: BaseModel {
    
    var userID: Int!
    var firstName: String!
    var lastName: String!
    var email: String!
    var phoneNumber: String!
    var profileUrl: String!
    var addressDesc: String!
    var s1ArrivalTime: Double!
    var s2ArrivalTime: Double!
    var s3ArrivalTime: Double!
    var s4ArrivalTime: Double!
    
    required init(json: JSON) {
        super.init(json: json)
        
        userID = json["Id"].intValue
        firstName = json["firstName"].stringValue
        lastName = json["LastName"].stringValue
        email = json["email"].stringValue
        phoneNumber = json["PhoneNumber"].stringValue
        profileUrl = json["ProfilePicture"].stringValue
        addressDesc = json["address"]["Description"].stringValue
        s1ArrivalTime = json["address"]["ArrivalTime"]["SendType1"].doubleValue
        s2ArrivalTime = json["address"]["ArrivalTime"]["SendType2"].doubleValue
        s3ArrivalTime = json["address"]["ArrivalTime"]["SendType3"].doubleValue
        s4ArrivalTime = json["address"]["ArrivalTime"]["SendType4"].doubleValue
    }
    
    override init() {
        super.init()
        
    }
}
