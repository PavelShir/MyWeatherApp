//
//  ViewModel.swift
//  MyWeatherApp
//
//  Created by Павел Широкий on 21.04.2025.
//

import Foundation
import CoreLocation

class WeatherViewModel: NSObject {
    
    var weatherManager = WeatherManager()
    private let locationManager = CLLocationManager()

    var onWeatherUpdated: ((WeatherModel) -> Void)?
    var onError: ((Error) -> Void)?
    
    override init() {
        super.init()
        weatherManager.delegate = self
        locationManager.delegate = self
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        locationManager.requestLocation()
    }

    func fetchWeather(for city: String) {
        weatherManager.fetchWeather(cityName: city)
    }
}

extension WeatherViewModel: WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel) {
        onWeatherUpdated?(weather)
    }

    func didFailWithError(error: Error) {
        onError?(error)
    }
}

extension WeatherViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        onError?(error)
    }
}
