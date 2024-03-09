//
//  WeatherModel.swift
//  MyWeatherApp
//
//  Created by Павел Широкий on 09.03.2024.
//

import Foundation

struct WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "xcloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.heavyrain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 801...804:
            return "cloud.sun"
        default:
            return "sun.max"
        }
    }
    
}
