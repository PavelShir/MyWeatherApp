//
//  WeatherManager.swift
//  MyWeatherApp
//
//  Created by Павел Широкий on 08.03.2024.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=871d0e672155deb7fd3a9fc81578cff4&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        // 1) create an URL
        if let url = URL(string: urlString) {
            
            // 2) create an URLSession
            let session = URLSession(configuration: .default)
            
            // 3) give the session a task
            let task = session.dataTask(with: url) { (data, respons, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatheData: safeData) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                    
                }
            }
            // 4) start the task
            task.resume()
        }
    }
    
    func parseJSON(weatheData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatheData.self, from: weatheData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
}
