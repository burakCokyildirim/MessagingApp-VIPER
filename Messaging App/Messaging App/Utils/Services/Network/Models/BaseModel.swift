//
//  BaseModel.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 2.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation
import SwiftyJSON

class BaseModel {
    
    init() {}
    required init(json _: JSON) {}

    func toJSON() -> JSON? {
        return nil
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dictionary[key] = child.value
            }
        }
        return dictionary
    }

    static func toModels<M: BaseModel>(json: JSON) -> [M] {
        return json.arrayValue.map({ M(json: $0) })
    }
}
