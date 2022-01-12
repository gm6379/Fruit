//
//  API.swift
//  Fruit
//
//  Created by George McDonnell on 20/04/2017.
//  Copyright © 2017 George McDonnell. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/**
 Connects to the Fruit data endpoints
 */
class API {

    /** Singleton instance */
    static let instance = API()
    
    /** The base url */
    let baseURL = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master"
    
    /**
     Performs a request to the fruit data
     */
    func fetchData(completion: @escaping (_ error: String?, _ fruit: [Fruit]?, _ loadingTime: String) -> Void) {
        let apiString = "\(baseURL)/data.json"
        
        Alamofire.request(apiString).responseJSON { response in
            let loadingTime = Int(response.timeline.requestDuration * 1000)
            let loadingStr = String(loadingTime)
            if let result = response.result.value {
                let json = JSON(result)
                if let fruit = Fruit.parse(json) {
                    completion(nil, fruit, loadingStr)
                } else {
                    completion("An error occurred while parsing the fruit data", nil, loadingStr)
                }
            } else {
                completion("No data returned from server", nil, loadingStr)
            }
        }
    }
    
    /**
     Performs a request to update the loading time stats
     */
    func updateLoadStats(loadingTime: String) {
        let apiString = "\(baseURL)/stats?event=load&data=\(loadingTime)"
        updateStatsWithURL(url: apiString)
    }
    
    /**
     Performs a request to update the display time stats
     */
    func updateDisplayStats(displayTime: String) {
        let apiString = "\(baseURL)/stats?event=display&data=\(displayTime)"
        updateStatsWithURL(url: apiString)
    }
    
    
    /**
     Performs a request to update the error stats
     */
    func updateErrorStats(error: String) {
        if let formattedError = error.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let apiString = "\(baseURL)/stats?event=error&data=\(formattedError)"
            updateStatsWithURL(url: apiString)
        }
    }
    
    /**
     Performs a request from a given url
     */
    func updateStatsWithURL(url: URLConvertible) {
        _ = Alamofire.request(url)
    }
}



