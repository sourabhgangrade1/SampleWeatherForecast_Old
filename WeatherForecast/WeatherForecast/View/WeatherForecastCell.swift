//
//  WeatherForecastCell.swift
//  WeatherForecast
//
//  Created by Wipro on 02/01/18.
//  Copyright © 2017 Saurabh Gngrade. All rights reserved.
//

import UIKit

class WeatherForecastCell: UITableViewCell {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureMinMaxLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateCellWith(_ weather: WeatherForecastViewModel.Weather) {
        
        guard let description = weather.weatherDescription else{
            return
        }
        self.weatherDescriptionLabel.text = description.capitalized
        
        guard let temperature = weather.temperature else{
            return
        }
        temperatureLabel.text = "\(temperature)" + "°C"


        guard let temperatureMin = weather.temperatureMin,
        let temperatureMax = weather.temperatureMax else{
            return
        }
        temperatureMinMaxLabel.text = "Min Temp: \(temperatureMin)°C   |   Max Temp: \(temperatureMax)°C"
        
        guard let date = weather.date else{
            return
        }
        dateLabel.text = DateUtil.getTimeStampwithFormat(date: date, format: "EEEE, dd MMM yyyy - h:mm a")
        
    }
}
