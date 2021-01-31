//
//  LetterModel.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 12.04.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation
import SwiftyJSON

class LetterModel: BaseModel {
    var id: String!
    var sendType: SendType!
    var paperType: PaperType!
    var envelopeType: EnvelopeType!
    var stampType: StampType!
    var deliveryTime: String!
    var fromUserId: String!
    var firstName: String!
    var lastName: String!
    var content: String!
    var incomingLetter = false
    
    required init(json: JSON) {
        super.init(json: json)
        
        id = json["Id"].stringValue
        sendType = SendType(rawValue: json["SendType"].intValue)
        paperType = PaperType(rawValue: json["PaperType"].intValue)
        envelopeType = EnvelopeType(rawValue: json["EnvelopeType"].intValue)
        stampType = StampType(rawValue: json["StampType"].intValue)
        deliveryTime = json["DeliveryTime"].stringValue
        fromUserId = json["FromUserId"].stringValue
        firstName = json["FirstName"].stringValue
        lastName = json["LastName"].stringValue
        content = json["Content"].stringValue
    }
    
    required init(json: JSON, incomingLetter: Bool = false) {
        super.init(json: json)
        
        id = json["Id"].stringValue
        sendType = SendType(rawValue: json["SendType"].intValue)
        paperType = PaperType(rawValue: json["PaperType"].intValue)
        envelopeType = EnvelopeType(rawValue: json["EnvelopeType"].intValue)
        stampType = StampType(rawValue: json["StampType"].intValue)
        deliveryTime = json["DeliveryTime"].stringValue
        fromUserId = json["FromUserId"].stringValue
        firstName = json["FirstName"].stringValue
        lastName = json["LastName"].stringValue
        content = json["Content"].stringValue
        
        self.incomingLetter = incomingLetter
    }
}
