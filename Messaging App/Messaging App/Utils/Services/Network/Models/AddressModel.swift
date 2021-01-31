//
//  AddressModel.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 9.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation
import SwiftyJSON

class AddressModel: BaseModel {
    var description: String!
    var lat: String!
    var lng: String!
    
    init(description: String, latitude: String, longitude: String) {
        super.init()
        
        self.description = description
        self.lat = latitude
        self.lng = longitude
    }
    
    required init(json: JSON) {
        super.init(json: json)
        
        description = json["Description"].stringValue
        lat = json["Lat"].stringValue
        lng = json["Lng"].stringValue
    }
}
