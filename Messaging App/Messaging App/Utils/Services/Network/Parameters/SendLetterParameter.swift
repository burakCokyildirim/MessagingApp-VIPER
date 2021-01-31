//
//  SendLetterParameter.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 19.04.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation

class SendLetterParameter: BaseParameter {
    var toUserId: Int!
    var envelopeType: Int!
    var stampType: Int!
    var paperType: Int!
    var sendType: Int!
    var letterContent: String!
    
    override func toDictionary() -> [String : Any]? {
        return [
            "toUserId": toUserId as Any,
            "envelopeType": envelopeType as Any,
            "stampType": stampType as Any,
            "paperType": paperType as Any,
            "sendType": sendType as Any,
            "letterContent": letterContent as Any]
    }
}
