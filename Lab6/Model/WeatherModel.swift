//
//  WeatherModel.swift
//  Lab6
//
//  Created by Sanjay Sekar Samuel on 2022-07-21.
//

import Foundation

struct WeatherModel{
    let conditionID: Int
    let cityName: String
    let weatherCondition: String
    let temperature: Double
    let humidity: Int
    let windSpeed: Double
    
    var temperatureFormatted: String {
        return String(format: "%.0f", temperature)
    }
    
    var windSpeedFormatted: String {
        // Multiply with 3.6 to convert m/s to km/hr
        let windInKM = windSpeed * 3.6
        return String(format: "%.0f", windInKM)
    }
    
    var conditionName: String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
    
}

