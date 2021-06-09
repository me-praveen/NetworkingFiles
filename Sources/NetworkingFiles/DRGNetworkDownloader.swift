//
//  File.swift
//  
//
//  Created by T, Praveen on 10/06/21.
//

import UIKit
import CoreData
import Alamofire

typealias SuccessType = () -> Void
typealias SuccessWithJsonType = (_ JSON: Any?) -> Void
typealias FailureType = () -> Void
typealias FailureTypeWithError = (_ error: AFError?) -> Void
public class DRGNetworkDownloader {
    
    var backgroundContext: NSManagedObjectContext?
    var resolvedURLString = ""
    var delegate: Any?
    
    init(backgroundContext aBackgroundContext: NSManagedObjectContext?, withDelegate delegate: Any?) {
        self.backgroundContext = aBackgroundContext
        self.delegate = delegate
    }
    
    // MARK: Methods overriden from parent
    
    func download() {
        download(withOptions: nil)
    }
    
    func download(withOptions opts: [String: Any]?){
    }
    
    func download(withOptions opts: [String: Any], success successBlock: SuccessType?, failure failureBlock: FailureType?) {
    }
    
    func download(withSuccess successBlock: SuccessWithJsonType?, failure failureBlock: FailureType?) {
    }
}
