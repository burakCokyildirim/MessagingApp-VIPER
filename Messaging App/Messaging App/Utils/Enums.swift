//
//  Enums.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 4.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation

enum PopupCloseType {
    case close
    case done
    case yes
    case no
}

enum SendType: Int {
    case sendType1 = 1
    case sendType2 = 2
    case sendType3 = 3
    case sendType4 = 4
    
    var value: Int {
        get {
            return self.rawValue
        }
    }
}

enum PaperType: Int {
    case paperType1 = 1
    case paperType2 = 2
    case paperType3 = 3
    case paperType4 = 4
    case paperType5 = 5
    case paperType6 = 6
    case paperType7 = 7
    case paperType8 = 8
    case paperType9 = 9
    case paperType10 = 10
    
    var index: Int {
        get {
            return self.rawValue - 1
        }
    }
    
    var value: Int {
        get {
            return self.rawValue
        }
    }
}

enum EnvelopeType: Int {
    case envelopeType1 = 1
    case envelopeType2 = 2
    case envelopeType3 = 3
    case envelopeType4 = 4
    case envelopeType5 = 5
    case envelopeType6 = 6
    case envelopeType7 = 7
    case envelopeType8 = 8
    case envelopeType9 = 9
    case envelopeType10 = 10
    
    var index: Int {
        get {
            return self.rawValue - 1
        }
    }
    
    var value: Int {
        get {
            return self.rawValue
        }
    }
}

enum StampType: Int {
    case stampType1 = 1
    case stampType2 = 2
    case stampType3 = 3
    case stampType4 = 4
    case stampType5 = 5
    case stampType6 = 6
    case stampType7 = 7
    case stampType8 = 8
    case stampType9 = 9
    case stampType10 = 10
    case stampType11 = 11
    case stampType12 = 12
    case stampType13 = 13
    case stampType14 = 14
    case stampType15 = 15
    
    var index: Int {
        get {
            return self.rawValue - 1
        }
    }
    
    var value: Int {
        get {
            return self.rawValue
        }
    }
}

enum ConfirmationViewState {
    case step1
    case step2(phoneNumber: String = "", countryCode: UInt64 = 0)
    case step3
}
