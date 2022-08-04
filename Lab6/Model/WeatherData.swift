//
//  WeatherData.swift
//  Lab6
//
//  Created by Sanjay Sekar Samuel on 2022-07-21.
//

import Foundation


// Weather data stored here in format as similar to the API call

struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}


struct Main: Codable{
    let temp: Double
    let humidity: Int
}

struct Wind: Codable{
    let speed: Double
}


struct Weather: Codable{
    let main: String
    let description: String
    let id: Int
}
