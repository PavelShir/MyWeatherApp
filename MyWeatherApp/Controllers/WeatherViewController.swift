//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Павел Широкий on 06.03.2024.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
   
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var locationButton: UIButton!
    
    let viewModel = WeatherViewModel()
    
  //  var weatherManager = WeatherManager()
  //  let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // определение делегата всегда должно быть в начале метода requestLocation()
        // locationManager.delegate = self
        //  locationManager.requestWhenInUseAuthorization()
        // locationManager.requestLocation()
        
        // weatherManager.delegate = self
        
        cityTextField.delegate = self
        
        viewModel.onWeatherUpdated = { [weak self] weather in
            DispatchQueue.main.async {
                self?.temperatureLabel.text = weather.temperatureString
                self?.weatherImage.image = UIImage(systemName: weather.conditionName)
                self?.cityLabel.text = weather.cityName
            }
        }
        
        viewModel.onError = { error in
            print("Error: \(error.localizedDescription)")
        }
        
        viewModel.requestLocationPermission()
        viewModel.requestLocation()
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        viewModel.requestLocation()
    }
    
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    // метод очищает текстовое поле, после написания и окончания редактирования
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = textField.text {
            viewModel.fetchWeather(for: city)
        }
        cityTextField.text = ""
    }
    // метод проверяет заполнено текстовое поле или нет
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Choose city"
            return false
        }
    }
    // метод срабатывает, когда нажимается кнопка Go
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityTextField.endEditing(true)
        return true
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        cityTextField.endEditing(true)
    }
}

//MARK: - WeatherManagerDelegate
/* 
 extension WeatherViewController: WeatherManagerDelegate {
 
 func didUpdateWeather(weather: WeatherModel) {
     DispatchQueue.main.async {
         self.temperatureLabel.text = weather.temperatureString
         self.weatherImage.image = UIImage(systemName: weather.conditionName)
         self.cityLabel.text = weather.cityName
     }
 }
 
 func didFailWithError(error: Error) {
     print(error)
 }
}
 */


//MARK: - LocationManagerDelegate

/*
 extension WeatherViewController: CLLocationManagerDelegate {
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         if let location = locations.last {
             locationManager.stopUpdatingLocation()
             let lat = location.coordinate.latitude
             let lon = location.coordinate.longitude
             weatherManager.fetchWeather(latitude: lat, longitude: lon)
         }
     }
     
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print(error)
     }
 }

 */
