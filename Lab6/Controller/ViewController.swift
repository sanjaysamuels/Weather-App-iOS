//
//  ViewController.swift
//  Lab6
//
//  Created by Sanjay Sekar Samuel on 2022-07-21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, WeatherManagerDelegate {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    let locationManager = CLLocationManager()
    //let APIkey = "bc0ebb20c48c6d65352bb9a1383344a9"
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        // Dispach Queue to wait for all networking process to end before updating
        DispatchQueue.main.async {
            self.cityNameLabel.text = weather.cityName
            self.weatherConditionLabel.text = weather.weatherCondition.capitalized
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.temperatureLabel.text = "\(weather.temperatureFormatted)°"
            self.humidityLabel.text = "\(String(weather.humidity))%"
            self.windLabel.text = "\(weather.windSpeedFormatted) km/h"
        }
    }
    
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let lat = locationManager.location?.coordinate.latitude
        let long = locationManager.location?.coordinate.longitude
        
        weatherManager.fetchWeather(lat: lat!, long: long!)
        
    }

    
}
