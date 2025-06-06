//
//  WeatherModelTests.swift
//  MyWeatherAppTests
//
//  Created by Павел Широкий on 06.06.2025.
//

import XCTest
@testable import MyWeatherApp

final class WeatherModelTests: XCTestCase {

    func testTemperatureStringFormatting() {
            let model = WeatherModel(conditionId: 800, cityName: "Moscow", temperature: 21.456)
            XCTAssertEqual(model.temperatureString, "21.5")
        }

        func testConditionNameSunny() {
            let model = WeatherModel(conditionId: 800, cityName: "Moscow", temperature: 20.0)
            XCTAssertEqual(model.conditionName, "sun.max")
        }

        func testConditionNameSnow() {
            let model = WeatherModel(conditionId: 602, cityName: "Moscow", temperature: -5.0)
            XCTAssertEqual(model.conditionName, "cloud.snow")
        }
}
