//
//  NetworkConstants.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 6.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation

struct NetworkConstants {
    fileprivate static let baseUrl = "https://api.test.com/api"
    static let contentType = ["Content-Type": "application/json"]
    
    static let login = NetworkConstants.baseUrl + "/login"
    static let register = NetworkConstants.baseUrl + "/register"
    static let sendSms = NetworkConstants.baseUrl + "/send-sms"
    static let phoneVerify = NetworkConstants.baseUrl + "/phone-verify"
    static let willComeLetter = NetworkConstants.baseUrl + "/incoming-letters-notarrived"
    static let willSendLetter = NetworkConstants.baseUrl + "/outgoing-letters-notarrived"
    static let didComeLetter = NetworkConstants.baseUrl + "/incoming-letters-arrived"
    static let didSendLetter = NetworkConstants.baseUrl + "/outgoing-letters-arrived"
    static let findUser = NetworkConstants.baseUrl + "/find-user"
    static let sendLetter = NetworkConstants.baseUrl + "/send-letter"
    static let revertLetter = NetworkConstants.baseUrl + "/delete-letter"
    static let forgotPassword = NetworkConstants.baseUrl + "/forgot-password"
    static let profile = NetworkConstants.baseUrl + "/profile"
    static let logout = NetworkConstants.baseUrl + "/logout"
    static let uploadPicture = NetworkConstants.baseUrl + "/update-user-profile"
    static let changePassowrd = NetworkConstants.baseUrl + "/change-password"
    static let updateAddress = NetworkConstants.baseUrl + "/update-user-address"
    static let blockUser = NetworkConstants.baseUrl + "/block-user"
    static let reportUser = NetworkConstants.baseUrl + "/report-user"
}
