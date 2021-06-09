//
//  File.swift
//  
//
//  Created by T, Praveen on 10/06/21.
//

import UIKit
import Alamofire

public class loginChecker: DRGNetworkDownloader {
    
    static let kTokensWebServiceActionURI = "/tokens"
    static let kEntitledUsersWebServiceActionURI = "/entitled_users"
    static var tok: String?
    
    
    public class func getTok(withParameters parameters: [AnyHashable : Any]?, success successBlock: @escaping (Any?, String?, String?) -> Void, failure failureBlock: @escaping () -> Void) {
        let kUserIDKey = "demoUserIDKey"
        let commonFailureBlock: (() -> Void) = {
            UserDefaults.standard.setValue(nil, forKey: kUserIDKey)
            UserDefaults.standard.setValue(nil, forKey: "entitlementsKey")
            UserDefaults.standard.setValue(nil, forKey: "entitlementsValues")
            UserDefaults.standard.setValue(nil, forKey: "entitlementsClientCodes");                            DRGHTTPConnectionManger.sharedInstance.authorizationHeaderValue = nil;
            failureBlock()
        }
        
        let overAllSuccessBlock: ((NSDictionary?) -> Void) = { userData in
            UserDefaults.standard.setValue(userData?["user_id"], forKey: kUserIDKey)
            UserDefaults.standard.setValue(userData?.value(forKeyPath: "entitlements.Key"), forKey: "entitlementsKey")
            UserDefaults.standard.setValue(userData?.value(forKeyPath: "entitlements.Value"), forKey: "entitlementsValues")
            UserDefaults.standard.setValue(userData?.value(forKeyPath: "client_codes"), forKey: "entitlementsClientCodes")
            UserDefaults.standard.setValue(userData?.value(forKeyPath: "roles"), forKey: "roles")
            
            successBlock(userData as? [String:Any], parameters?["user"] as? String, DRGHTTPConnectionManger.sharedInstance.authorizationHeaderValue)
        }
        downloadToken(withParameters: parameters, success: { (json) in
            if let token = json as? String{
                DRGHTTPConnectionManger.sharedInstance.authorizationHeaderValue = token;
            }
            self.downloadEntitlements(withSuccess:overAllSuccessBlock , failure: commonFailureBlock)
        }, failure: commonFailureBlock)
    }
    
    class func downloadToken(withParameters parameters: [AnyHashable : Any]?, success successBlock: @escaping (Any?) -> Void, failure failureBlock: @escaping () -> Void) {
        if DRGHTTPClient.sharedInstance.networkIsAvailable {
            var requestDict = [String: Any]()
            requestDict["user"] = parameters?["user"]
            requestDict["password"] = (parameters?["password"] as? String)?.encodeToBase64()
            
            DRGHTTPConnectionManger.sharedInstance.makePOSTRequest(path: kTokensWebServiceActionURI, parameters: requestDict, successBlock: { (json) in
                
                DispatchQueue.main.async {
                    successBlock(json)
                }
                
                let queue = DispatchQueue(label: "com.fingertipformulary.network.drugs")
                queue.async(execute: {() -> Void in
                    //dfaf
                })
                //agsg
            }) {(error) in
                DispatchQueue.main.async {
                    failureBlock()
                }
            }
            
        } else {
            print("Network Not Available")
            
    }
    }
    
    class func downloadEntitlements(withSuccess successBlock: @escaping (NSDictionary?) -> Void, failure failureBlock: @escaping () -> Void) {
        if DRGHTTPClient.sharedInstance.networkIsAvailable {
        //    var requestDict: [AnyHashable : Any] = [:]
            DRGHTTPConnectionManger.sharedInstance.makePOSTRequest(path: kEntitledUsersWebServiceActionURI, parameters: nil, successBlock: { (json) in
                //if successBlock {
                    DispatchQueue.main.async(execute: {
                        successBlock(json as? NSDictionary)
                    })
                //}
            }) {(error) in
                //if failureBlock != nil {
                    DispatchQueue.main.async(execute: failureBlock)
                    
                //}
                failureBlock()
            }
        } else {
            print("Network Not Available")
            failureBlock()
        }
    }
}

