//
//  BaseParameter.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 6.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation

class BaseParameter {
    
    init() {}
    
    func toDictionary() -> [String: Any]? {
       return nil
    }
    
    static func toDictionaries<P: BaseParameter>(parameters: [P]) -> [[String: Any]?] {
        return parameters.map({ $0.toDictionary() })
    }
    
}
