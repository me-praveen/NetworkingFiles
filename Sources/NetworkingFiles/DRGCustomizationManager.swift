//
//  File.swift
//  
//
//  Created by T, Praveen on 10/06/21.
//

import Foundation

import UIKit

public class DRGCustomizationManager: NSObject {
    
    #if DEVELOPMENT_SERVICES
    private static var webservicesBaseURL = "https://mylan-publisher_api.devweb01.fingertipformulary.com"
    #else
    private static var webservicesBaseURL = "https://mylan-publisher_api.fingertipformulary.com"
    //this is for AppStore targetas well
    #endif
    
    private static var LoginURL2 = "https://mylan-publisher.devweb01.fingertipformulary.com/custom_templates"
    private static var PRODUCT_MYLAN = "https://mylan-publisher.devweb01.fingertipformulary.com"
    
    
    public class func webservicesURL() -> String {
        return webservicesBaseURL
    }
    
    public class func LoginURL() -> String {
        return LoginURL2
    }
    
 
}

