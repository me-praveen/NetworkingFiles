//
//  File.swift
//  
//
//  Created by T, Praveen on 10/06/21.
//

import UIKit
import Alamofire

struct Router: URLConvertible {
    static let baseURLString:String =  DRGCustomizationManager.webservicesURL()
    var path : String
    func asURL() throws -> URL {
        let url = try (Router.baseURLString + path).asURL()
        return url
    }
}

class DRGHTTPClient: Session {
    
    public var networkIsAvailable: Bool = false
    var checkedForConnection: Bool = false
    var networkReachableManager: NetworkReachabilityManager?
    var configuraton:URLSessionConfiguration?
    //var rootQueue:DispatchQueue?
    
    
    static let sharedInstance: DRGHTTPClient = {
        let serverTrustPolicies: [String: ServerTrustEvaluating] = [:]
        var defaultHeaders = DRGHTTPClient.default
        //        defaultHeaders["Authorization"] = ""
        let rootQueue = DispatchQueue(label: "org.DRG.customQueue")
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.underlyingQueue = rootQueue
        let delegate = SessionDelegate()
        let configuration = URLSessionConfiguration.af.default
        let urlSession = URLSession(configuration: configuration,delegate: delegate,delegateQueue: queue)

        let manager = DRGHTTPClient( session: urlSession, delegate: delegate, rootQueue:rootQueue )
        let eventMonitors: [EventMonitor] = []

        manager.configuraton = configuration
        
        //Wait until monitoring of network is done.
        //todo: what about the situation that network is not available? Stuck in infinite while loop?

        while(!manager.checkedForConnection ) {
            manager.initiateNetWorkMonitoring()
        }
        return manager
    }()
    
    
    func initiateNetWorkMonitoring() {
        guard self.networkReachableManager == nil else {
            return
        }
   
        if let networkReachableManager = NetworkReachabilityManager(){
            self.networkReachableManager = networkReachableManager

            if(self.networkReachableManager!.isReachable) {
                self.networkIsAvailable = networkReachableManager.isReachable
                self.checkedForConnection = true
            }
            else {
                self.networkIsAvailable = networkReachableManager.isReachable
                self.checkedForConnection = true
            }
      /*
            self.networkReachableManager?.startListening (onUpdatePerforming: { networkStatusListener in
                
                switch networkStatusListener {
             
                case .notReachable:
 
                        print("The network is not reachable.")
                case .unknown :

                            print("It is unknown whether the network is reachable.")
                case .reachable(.ethernetOrWiFi):
                            print("The network is reachable over the WiFi connection")
                            self.networkIsAvailable = networkReachableManager.isReachable
                            self.checkedForConnection = true

                case .reachable(.cellular):
                            print("The network is reachable over the WWAN connection")
                            self.networkIsAvailable = networkReachableManager.isReachable
                            self.checkedForConnection = true
    
                }
            })
    */
    
        }
    }

}
