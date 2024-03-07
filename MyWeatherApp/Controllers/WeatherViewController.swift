//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Павел Широкий on 06.03.2024.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    let weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTextField.delegate = self
    }

    // метод очищает текстовое поле, после написания и окончания редактирования
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = textField.text {
            weatherManager.fetchWeather(cityName: city)
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

