//
//  WeatherAPIService.swift
//  WeatherForecast
//
//  Created by Saurabh Gngrade on 01/01/18.
//  Copyright © 2017 Saurabh Gngrade. All rights reserved.
//

import UIKit
fileprivate var appID = "8c772618656eced1a32a604c0d742915"
import PromiseKit

class WeatherForecastService: NSObject {

    func getWeatherForeCast(address: String) -> Promise<Array<Any>> {
        
        return Promise { fulfill, reject in
            
            let urlString = "http://api.openweathermap.org/data/2.5/forecast?q=\(address)&appid=\(appID)"
            let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
            let request = URLRequest(url: url)
            let session = URLSession.shared
            let dataPromise: URLDataPromise = session.dataTask(with: request)
            
            _ = dataPromise.asDictionary().then { dictionary -> Void in
                
                var weatherObjects:[WeatherForecastViewModel.Weather]?
                guard let list = dictionary["list"] as? [Dictionary<String, AnyObject>] else {
                    let error = NSError(domain: "PromiseKitTutorial", code: 0,
                                        userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
                    reject(error)
                    return
                }
                weatherObjects = Array()
                for item in list {
                    
                    if let weather = WeatherForecastViewModel.Weather(jsonDict: item) {
                        weatherObjects?.append(weather)
                    }
                }
                weatherObjects!.sort(by: { $0.date.compare($1.date) == .orderedAscending})
                fulfill(weatherObjects!)
                
                }.catch(execute: reject)
        }
    }
}
