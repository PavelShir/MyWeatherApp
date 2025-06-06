//
//  WeatherViewModelTests.swift
//  MyWeatherAppTests
//
//  Created by Павел Широкий on 06.06.2025.
//

import XCTest
@testable import MyWeatherApp

final class WeatherViewModelTests: XCTestCase {

    func testWeatherUpdateCallbackIsCalled() {
            let viewModel = WeatherViewModel()

            let expectation = self.expectation(description: "Weather update called")
            let fakeWeather = WeatherModel(conditionId: 800, cityName: "Paris", temperature: 23.5)

            viewModel.onWeatherUpdated = { weather in
                XCTAssertEqual(weather.cityName, "Paris")
                XCTAssertEqual(weather.temperature, 23.5)
                expectation.fulfill()
            }

            viewModel.didUpdateWeather(weather: fakeWeather)
            waitForExpectations(timeout: 1.0)
        }

        func testErrorCallbackIsCalled() {
            let viewModel = WeatherViewModel()

            let expectation = self.expectation(description: "Error callback called")

            viewModel.onError = { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }

            viewModel.didFailWithError(error: NSError(domain: "", code: -1))
            waitForExpectations(timeout: 1.0)
        }

}
