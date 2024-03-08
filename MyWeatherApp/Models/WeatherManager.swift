//
//  WeatherManager.swift
//  MyWeatherApp
//
//  Created by Павел Широкий on 08.03.2024.
//

import Foundation

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=b6956b9273642c29f7a098f48e56d99b&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
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
                    print("Error")
                    return
                }
                if let safeData = data {
                    self.parseJSON(weatheData: safeData)
                }
            }
            // 4) start the task
            task.resume()
        }
    }
    
    func parseJSON(weatheData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatheData.self, from: weatheData)
            print("\(decodedData.main.temp) \(decodedData.weather[0].description)")
        } catch {
            print(error)
        }
        
    }
    
}
