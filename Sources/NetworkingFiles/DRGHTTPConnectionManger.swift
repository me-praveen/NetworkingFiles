//
//  File.swift
//  
//
//  Created by T, Praveen on 10/06/21.
//

import UIKit
import Alamofire

public class DRGHTTPConnectionManger: NSObject {
    public static let sharedInstance = DRGHTTPConnectionManger()
    
    var authorizationHeaderValue: String?
    
    public final var authorizationHeader: [String: String] {
        get {
            return ["AUTHORIZATION": self.authorizationHeaderValue ?? ""]
        }
    }
    
    final func makeGETRequest(path:String, successBlock:SuccessWithJsonType?, failureBlock:FailureType?) {
       let httpHeaders = HTTPHeaders(self.authorizationHeader)
        let params: Parameters? = nil
        DRGHTTPClient.sharedInstance.request(Router(path:path), method: .get, parameters: params, headers: httpHeaders).validate(statusCode: 200..<300).responseJSON { (response) in
        print(response)
           switch response.result {
           case .success(let value):
            successBlock?(value)
               
           case .failure:
                failureBlock?()
                return
           
            }
        }
    }
    final func makeGETRequest(path:String, parameters:[String:Any], successBlock:SuccessWithJsonType?, failureBlock:FailureType?) {
        
        let httpHeaders = HTTPHeaders(self.authorizationHeader)
        DRGHTTPClient.sharedInstance.request(Router(path:path), method: .get, parameters: parameters, headers: httpHeaders).validate(statusCode: 200..<300).responseJSON {(response) in
            switch response.result {
            case .success(let value):
                successBlock?(value)
                
            case .failure:
                 failureBlock?()
                 return
            
             }
        }
        
    }
    
    final func makePOSTRequest(path:String, parameters:[String:Any]? , successBlock:SuccessWithJsonType?, failureBlock:FailureTypeWithError?) {
       
        let httpHeaders = HTTPHeaders(self.authorizationHeader)
        //bug returns failure
        DRGHTTPClient.sharedInstance.request(Router(path:path), method: .post, parameters: parameters, headers: httpHeaders ).validate(statusCode: 200..<300).responseJSON { (response) in
            print(response.result)
            
            switch response.result {
            case .success(let value):
                successBlock?(value)

            case .failure:
                failureBlock?(response.error)
                 return
            
             }
            
        }
    }
    
    final func makeDELETERequest(path:String, parameters:[String:Any]? , successBlock:SuccessWithJsonType?, failureBlock:FailureType?) {
        
        let httpHeaders = HTTPHeaders(self.authorizationHeader)
        DRGHTTPClient.sharedInstance.request(Router(path:path), method: .delete, parameters: parameters, headers: httpHeaders).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                successBlock?(value)
                
            case .failure:
                 if response.response?.statusCode == 200 {
                    successBlock?(nil)
                } else {
                    failureBlock?()
                }
                return
            
             }
            
        }
    }
}

