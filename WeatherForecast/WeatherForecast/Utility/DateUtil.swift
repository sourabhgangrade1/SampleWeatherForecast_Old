//
//  DateUtil.swift
//  WeatherForecast
//
//  Created by Saurabh Gangrade on 03/01/18.
//  Copyright © 2018 Saurabh Gangrade. All rights reserved.
//

import UIKit

class DateUtil: NSObject {

    class func getDateFromString(strDate: String)->Date?{
            let dateFormat = "yyyy-MM-dd HH:ss:zz"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            let date = dateFormatter.date(from: strDate)
            return date

        }
    
    class func getTimeStampwithFormat(date: Date, format:String)->String{
            let dateFormat = format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            let dateStr = dateFormatter.string(from: date)
            return dateStr
        }
}
