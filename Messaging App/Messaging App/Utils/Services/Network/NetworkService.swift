
//
//  NetworkService.swift
//  AdessoProjectTemplate
//
//  Created by Zafer Caliskan on 8.01.2018.
//  Copyright © 2018 adesso. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Kingfisher

class NetworkService {
    
    typealias SuccessCompletionHandler = (_ result: JSON) -> Void
    typealias FailureCompletionHandler = (ErrorModel) -> Void
    
    static let sharedInstance = NetworkService()
    
    fileprivate var reachabilityManager: NetworkReachabilityManager?
    var reachabilityStatus: NetworkReachabilityManager.NetworkReachabilityStatus = .unknown
    
    open class MyServerTrustPolicyManager: ServerTrustPolicyManager {
        
        open override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
            return ServerTrustPolicy.disableEvaluation
        }
    }
    
    static let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        return configuration
    }()
    
    var imageDownloader: ImageDownloader = {
       var imageDownloader = ImageDownloader.default
        imageDownloader.trustedHosts = Set(["api.test.com"])
        
        return imageDownloader
    }()
    
    let sessionManager = SessionManager(configuration: configuration, delegate: SessionDelegate(), serverTrustPolicyManager: MyServerTrustPolicyManager(policies: [:]))
    
//    let sessionManager = SessionManager(configuration: configuration)
    
    var jSessionId: String?
    
    private init() {
        KingfisherManager.shared.downloader = imageDownloader
    }
    
    // MARK: - Reachability
    
    func startReachability(listener: NetworkReachabilityManager.Listener? = nil) {
        reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
        reachabilityManager?.listener = { status in
            self.reachabilityStatus = status
            
            if let listener = listener {
                listener(status)
            }
        }
        reachabilityManager?.startListening()
    }
    
    func stopReachabilityManager() {
        reachabilityManager?.stopListening()
    }
    
    // MARK: - Methods
    
    func getJSON(url: URLConvertible, parameters: [String: Any]? = nil, headers: [String: String]? = nil,
                 success: @escaping SuccessCompletionHandler, failure: @escaping FailureCompletionHandler) {
        callJSON(method: .get, url: url, parameters: parameters, headers: headers, success: success, failure: failure)
    }
    
    func postJSON(url: URLConvertible, parameters: [String: Any]? = nil, headers: [String: String]? = nil,
                  success: @escaping SuccessCompletionHandler, failure: @escaping FailureCompletionHandler) {
        callJSON(method: .post, url: url, parameters: parameters, headers: headers, success: success, failure: failure)
    }
    
    fileprivate func callJSON(method: HTTPMethod, url: URLConvertible,
                              parameters: [String: Any]? = nil, headers: [String: String]? = nil,
                              success: @escaping SuccessCompletionHandler, failure: @escaping FailureCompletionHandler) {
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
//
//            guard let data = self.readFromBundle(url) else {
//                return
//            }
//
//            let json = JSON(parseJSON: data)
//
//            if json["success"].boolValue {
//                if json["customData"].exists() {
//                    print("Response Custom Data: \(json["customData"])\n")
//                    success(json["customData"])
//                } else {
//                    print("Response Data: \(json["data"])\n")
//                    success(json["data"])
//                }
//            } else {
//                self.handleError(json, success: success, failure: failure)
//            }
//        }
//        return

        if isInternetAvailable() {
            
            var headerParams = [String: String]()
            if let headers = headers {
                headerParams = headers
            }
            
            if let cookieHeader = jSessionId?.replacingOccurrences(of: ".fusemaftst", with: "").replacingOccurrences(of: ".esmaftst", with: "") {
                headerParams["Cookie"] = "JSESSIONID=\(cookieHeader)"
            }
            let headerParameters = addHeaders(headers: headerParams)
            print("Url: \(url)\n")
            do {
                if try url.asURL().lastPathComponent != "submitPersonalInformation" {
                    print("Request Parameters: \(String(describing: parameters))\n")
                }
            } catch {
                
            }
            print("Header Parameters: \(String(describing: headerParameters))\n")
            
            sessionManager.request(url, method: method, parameters: parameters,
                                   encoding: JSONEncoding.default, headers: headerParameters)
                .responseJSON(completionHandler: { response in
                    if let headerFields = response.response?.allHeaderFields as? [String: String],
                        let URL = response.request?.url {
                        let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: URL)
                        if let jSessionIDCookie = cookies.filter({ $0.name == "JSESSIONID" }).first {
                            self.jSessionId = jSessionIDCookie.value
                        }
                    }
                    print("JSESSIONID: \(String(describing: self.jSessionId))\n")
                    
                    print("Response: " + (String(bytes: response.data!, encoding: .utf8) ?? "nil"))
                    switch response.result {
                    case .success(let data):
                        let json = JSON(data)
                        if json["statusCode"].int == 999 {
                            self.handleError(json, success: success, failure: failure)
                            return
                        }
                        success(json)
                    case .failure(let error):
                        if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
                            print("Response Failure Not Connected: \(urlError)\n")
                            failure(ErrorModel(genericErrorType: GenericErrorType.reachability))
                        } else {
                            self.handleHttpError(response.response, success: success, failure: failure)
                        }
                    }
                })
        } else {
            print("Response Failure Reachability: \n")
            failure(ErrorModel(genericErrorType: GenericErrorType.reachability))
        }
    }
    
    func upload(url: URLConvertible, multipartFormDatas: [(Data, String, String, String)], parameters: [String: Any]? = nil,
                success: @escaping SuccessCompletionHandler, failure: @escaping FailureCompletionHandler) {

        sessionManager.upload(multipartFormData: { (multipartFormData) in
            multipartFormDatas.forEach { multipartFormData.append($0.0, withName: $0.1, fileName: $0.2, mimeType: $0.3) }
            if let parameters = parameters {
                for (key, value) in parameters {
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                }
            }
        }, to: url) { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                }
                
                upload.responseJSON { (response) in
                    guard let data = response.data else{
                        failure(Errors.somethingsWrong)
                        return
                    }
                    
                    let json = JSON(data)
                    if json["statusCode"].int == 999 {
                        self.handleError(json, success: success, failure: failure)
                        return
                    }
                    success(json)
                }
                
            case .failure(let error):
                if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
                    print("Response Failure Not Connected: \(urlError)\n")
                    failure(ErrorModel(genericErrorType: GenericErrorType.reachability))
                } else {
                    self.handleHttpError(nil, success: success, failure: failure)
                }
            }
        }
    }
    
    func callStaticDataString(url: URLConvertible, success: @escaping (_ result: String) -> Void, failure: @escaping FailureCompletionHandler) {
        
        sessionManager.request(url).responseString { (data) in
            print(data)
            switch data.result {
            case .success(let string):
                success(string)
            case .failure:
                failure(ErrorModel(genericErrorType: GenericErrorType.somethingsWrong))
            }
        }
    }
    
    func callStaticData(url: URLConvertible, success: @escaping (_ result: String) -> Void, failure: @escaping FailureCompletionHandler) {
        sessionManager.request(url).responseData { (data) in
            print(data)
            
        }
    }
    
    // MARK: - Utils

    func isInternetAvailable() -> Bool {
        switch reachabilityStatus {
        case .notReachable:
            return false
        case .unknown:
            return true
        case .reachable(.ethernetOrWiFi):
            return true
        case .reachable(.wwan):
            return true
        }
    }
    
    func addHeaders(headers: [String: String]? = nil) -> [String: String]? {
        var headerParameters: [String: String]?
        
        if let defaultHeaders = NetworkService.defaultHeaders() {
            headerParameters = defaultHeaders
        }
        
        if let parameters = headers {
            if headerParameters == nil {
                headerParameters = [String: String]()
            }
            headerParameters?.merge(parameters, uniquingKeysWith: { $1 })
        }
        return headerParameters
    }
    
    // MARK: - Error Handling
    
    func handleError(_ json: JSON, success: @escaping SuccessCompletionHandler, failure: @escaping FailureCompletionHandler) {
        print("Response Failure Handle Error: \(json)\n")
        
        if json["statusCode"].int == 999 {
            failure(ErrorModel(genericErrorType: GenericErrorType.tokenExpired))
        }
        
//        let errorJSON = json["error"]
//        let validationsJSON = json["validations"].array
//
//        if errorJSON["errorCode"] == "warning_token_expire" {
//            failure(ErrorModel(genericErrorType: GenericErrorType.tokenExpired, errorMessage: "warning_token_expire".localized))
//
//            return
//        } else if errorJSON["type"] == "VALIDATION" {
//            if let validation = validationsJSON?.first {
//                failure(ErrorModel(genericErrorType: GenericErrorType.validation, errorMessage: validation["message"].stringValue))
//
//                return
//            }
//        }
        
//        failure(ErrorModel(json: errorJSON))
    }
    
    func handleHttpError(_ response: HTTPURLResponse?, success: @escaping SuccessCompletionHandler, failure: @escaping FailureCompletionHandler) {
        if let statusCode = response?.statusCode {
            print("Response Failure Http Status Code: \(statusCode)\n")
            failure(ErrorModel(errorCode: "\(statusCode)", genericErrorType: GenericErrorType.somethingsWrong))
        } else {
            print("Response Failure Http Somethings Wrong: \n")
            failure(ErrorModel(genericErrorType: GenericErrorType.somethingsWrong))
        }
    }
    
    // MARK: - Parameter Utils
    
    static func defaultHeaders() -> [String: String]? {
        return nil
    }
    
    static func getToken() -> String? {
        return nil//UserDefaults.standard.string(forKey: UserDefaultConstants.token)
    }
    
    // MARK: - Mock
    
    fileprivate func readFromBundle(_ urlConvertible: URLConvertible) -> String? {
        do {
            let url =  try urlConvertible.asURL()
            
            guard let fileInBundle = Bundle.main.path(forResource: url.lastPathComponent, ofType: "json") else {
                return nil
            }
            print("......................................................")
            print(fileInBundle)
            print("......................................................")
            return try String(contentsOfFile: fileInBundle)
        } catch {
            
        }
        
        return nil
    }
    
}
