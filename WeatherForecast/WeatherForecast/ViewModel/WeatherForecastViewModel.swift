//
//  WeatherForecastViewModel.swift
//  WeatherForecast
//
//  Created by Saurabh Gngrade on 01/01/18.
//  Copyright © 2017 Saurabh Gngrade. All rights reserved.
//

import UIKit
import CoreLocation
import PromiseKit

protocol  WeatherForecastViewModelDelegate {
    func didFinishLoadingWeatherDatawithError(withError error: Error?)
    func didFinishLoadingWeatherData(withData data:Array<Any>)

}
class WeatherForecastViewModel: NSObject {

    var weatherData: NSArray?
    var delegate: WeatherForecastViewModelDelegate?
    let weatherAPI = WeatherForecastService()


    struct Weather {

        var date:Date!
        var temperature:String!
        var weatherDescription:String!
        var temperatureMin:String!
        var temperatureMax:String!

        init?(jsonDict:Dictionary<String, AnyObject>) {

            guard let dateStr = jsonDict["dt_txt"] as? String,
                let date = DateUtil.getDateFromString(strDate: dateStr),
                let mainDict = jsonDict["main"] as? Dictionary<String, AnyObject>,
                let temperature = mainDict["temp"] as? Double,
                let temperatureMin = mainDict["temp_min"] as? Double,
                let temperatureMax = mainDict["temp_max"] as? Double,
                let weather = (jsonDict["weather"] as? [Dictionary<String, AnyObject>])?.first,
                let weatherDesc = weather["description"] as? String
                else {
                    return nil
            }

            let temperatureCelcius = String(format: "%.0f", temperature - 273.15)
            let temperatureCelciusMin = String(format: "%.0f", temperatureMin - 273.15)
            let temperatureCelciusMax = String(format: "%.0f", temperatureMax - 273.15)

            self.date = date
            self.temperature = temperatureCelcius
            self.temperatureMin = temperatureCelciusMin
            self.temperatureMax = temperatureCelciusMax
            self.weatherDescription = weatherDesc
        }

    }

    func getWeatherForeCastData(address: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        _ = weatherAPI.getWeatherForeCast(address: address).then { weather -> Void in
            self.weatherData = weather as NSArray
            return (self.delegate?.didFinishLoadingWeatherData(withData:weather))!
            }.catch { error in
                
                
            }.always {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }

    }

}


