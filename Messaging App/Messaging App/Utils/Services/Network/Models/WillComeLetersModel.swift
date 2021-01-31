//
//  WillComeLetersModel.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 12.04.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation
import SwiftyJSON

class WillComeLetersModel: BaseModel {
    var letters: [LetterModel]!

    required init(json: JSON) {
        super.init(json: json)
        
        letters = json["letters"].arrayValue.map { LetterModel(json: $0)}
    }
}
