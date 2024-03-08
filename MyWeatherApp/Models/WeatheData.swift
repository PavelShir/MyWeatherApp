//
//  File.swift
//  MyWeatherApp
//
//  Created by Павел Широкий on 08.03.2024.
//

import Foundation

struct WeatheData: Decodable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
}
