//
//  LoginModel.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 7.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginModel: BaseModel {
    
    var userModel: UserModel!
    
    required init(json: JSON) {
        super.init(json: json)
        
        userModel = UserModel(json: json["user"])
    }
}
