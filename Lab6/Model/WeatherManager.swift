//
//  WeatherManager.swift
//  Lab6
//
//  Created by Sanjay Sekar Samuel on 2022-07-21.
//

import Foundation


protocol WeatherManagerDelegate{
    // Calling method with no external parameter name
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
}

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=bc0ebb20c48c6d65352bb9a1383344a9&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(lat: Double, long: Double){
        // appending the lat long to the urlstring
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(long)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        // Checking if url exists
        if let url = URL(string: urlString){
            // If url exists start session
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data{
                    if let weatherMod = parseJSON(weatherData: safeData){
                        delegate?.didUpdateWeather(self, weather: weatherMod)
                        //VC.updateWeather(weather: weatherMod)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        // Storing the data from Open weather API to the weather data struct
        do{
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let conditionID = decodeData.weather[0].id
            let cityName = decodeData.name
            let weatherCondition = decodeData.weather[0].description
            let temperature = decodeData.main.temp
            let humidity = decodeData.main.humidity
            let windSpeed = decodeData.wind.speed
            
            let weather = WeatherModel(conditionID: conditionID, cityName: cityName, weatherCondition: weatherCondition, temperature: temperature, humidity: humidity, windSpeed: windSpeed)
            return weather
            
        } catch{
            print(error)
            return nil
        }
    }
}
