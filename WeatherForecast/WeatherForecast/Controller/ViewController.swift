//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Saurabh Gngrade on 31/12/17.
//  Copyright © 2017 Saurabh Gngrade. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, WeatherForecastViewModelDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var locationSearchBar: UISearchBar!
    
    @IBOutlet var viewModel: WeatherForecastViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WeatherForecastViewModel()
        viewModel?.delegate = self
        weatherTableView.tableFooterView = UIView()
        locationSearchBar.becomeFirstResponder()

    }
    func didFinishLoadingWeatherDatawithError(withError error: Error?){
        
        
    }
    func didFinishLoadingWeatherData(withData data:Array<Any>){

        DispatchQueue.main.async{
            self.weatherTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard (viewModel?.weatherData?.count) != nil else {
            return 0
        }
        return (viewModel?.weatherData?.count)!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherForecastCell",
                                                       for: indexPath) as? WeatherForecastCell else {
                                                        return UITableViewCell()
        }
        cell.selectionStyle = .none
        let weather = viewModel?.weatherData?[indexPath.row]
        cell.updateCellWith(weather as! WeatherForecastViewModel.Weather)
        return cell
    }
    
}
    
//MARK:UISearchBarDelegate methods
extension ViewController: UISearchBarDelegate {
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

            guard let searchStr = searchBar.text else {
                return
                }
            viewModel?.getWeatherForeCastData(address: searchStr)
            searchBar.resignFirstResponder()
        }
    }

