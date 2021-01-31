//
//  ErrorModel.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 2.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation
import SwiftyJSON

enum GenericErrorType: String, Error {
    
    case reachability = "error_message.has_no_internet"
    case httpError = "error_message.http_error"
    case somethingsWrong = "error_message.somethings_wrong"
    case parseError = "error_message.parse_error"
    case tokenExpired = "error_message.token_expired"
    case validation = "error_message.validation_error"
    case wrongPassword = "error_message.wrong_passowrd"
    case oldWrongPassword = "error_message.old_wrong_passowrd"
    case wrongCode = "error_message.wrong_code"
    case emailActivationRequired = "error_message.email_activation_required"
    case emailInUse = "error_message.email_in_use"
    case phoneInUse = "error_message.phone_in_use"
    case emailNotExist = "error_message.email_not_exist"
    case notSelectedAddress = "error_message.please_select_address"
    case unexpected = "error_message.unexpected_error"
    case invalidPhoneNumber = "error_message.invalid_phone_number"
    
    var localizableMessage: String {
        return self.rawValue.localized
    }
    
}

struct Errors {
    static let wrongPassword = ErrorModel(genericErrorType: .wrongPassword)
    static let oldWrongPassword = ErrorModel(genericErrorType: .oldWrongPassword)
    static let wrongCode = ErrorModel(genericErrorType: .wrongCode)
    static let emailActivationRequired = ErrorModel(genericErrorType: .emailActivationRequired)
    static let somethingsWrong = ErrorModel(genericErrorType: .somethingsWrong)
    static let notSelectedAddress = ErrorModel(genericErrorType: .notSelectedAddress)
    static let validation = ErrorModel(genericErrorType: .validation)
    static let unexpected = ErrorModel(genericErrorType: .unexpected)
    static let emailInUse = ErrorModel(genericErrorType: .emailInUse)
    static let phoneInUse = ErrorModel(genericErrorType: .phoneInUse)
    static let emailNotExist = ErrorModel(genericErrorType: .emailNotExist)
}

class ErrorModel: BaseModel {
    var errorCode: String!
    var errorMessage: String!
    var errorType: ErrorType!
    var genericErrorType: GenericErrorType?
    
    static let `default` = ErrorModel(genericErrorType: .somethingsWrong)
    
    required init(json: JSON) {
        super.init(json: json)

        errorCode = json["errorCode"].stringValue
        errorMessage = json["message"].stringValue
        if let messageType = json["messageType"].int8 {
            errorType = ErrorType(rawValue: messageType)
        } else {
            errorType = ErrorType.error
        }
    }
    
    init(errorCode: String, errorMessage: String, errorType: ErrorType) {
        super.init()
        
        self.errorCode = errorCode
        self.errorMessage = errorMessage
        self.errorType = errorType
    }

    init(genericErrorType: GenericErrorType) {
        super.init()

        self.errorCode = genericErrorType.rawValue
        self.errorMessage = genericErrorType.localizableMessage
        self.errorType = ErrorType.generic
        self.genericErrorType = genericErrorType
    }
    
    init(genericErrorType: GenericErrorType, errorMessage: String) {
        super.init()
        
        self.errorCode = genericErrorType.rawValue
        self.errorMessage = errorMessage
        self.errorType = ErrorType.generic
        self.genericErrorType = genericErrorType
    }
    
    init(errorCode: String, genericErrorType: GenericErrorType) {
        super.init()
        
        self.errorCode = errorCode
        self.errorMessage = genericErrorType.localizableMessage
        self.errorType = ErrorType.generic
        self.genericErrorType = genericErrorType
    }
}

enum ErrorType: Int8 {
    case unknown = 0
    case warning = 1
    case error = 2
    case generic = 3
    
    static var all: [ErrorType] {
        return [.unknown, .warning, .error, .generic]
    }
    
    static var `default`: ErrorType {
        return ErrorType.error
    }
    
}

extension ErrorType: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .unknown:
            return "unknown".localized
        case .warning:
            return "warning".localized
        case .error:
            return "error".localized
        case .generic:
            return "generic".localized
        }
    }
    
    public var localized: String {
        return description
    }
    
}
