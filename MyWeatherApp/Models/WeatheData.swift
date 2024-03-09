//
//  File.swift
//  MyWeatherApp
//
//  Created by Павел Широкий on 08.03.2024.
//

import Foundation

struct WeatheData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}

struct Coord: Codable {
    let lat: Double
    let lon: Double
}
