//
//  WeatherManagerTests.swift
//  MyWeatherAppTests
//
//  Created by Павел Широкий on 06.06.2025.
//

import XCTest
@testable import MyWeatherApp

final class WeatherManagerTests: XCTestCase {

    func testParseJSONReturnsModel() throws {
            // Мокаем JSON
            let json = """
            {
                "weather": [{"id": 800}],
                "main": {"temp": 25.0},
                "name": "London"
            }
            """.data(using: .utf8)!

            let manager = WeatherManager()
            let result = manager.parseJSON(weatheData: json)

            XCTAssertNotNil(result)
            XCTAssertEqual(result?.cityName, "London")
            XCTAssertEqual(result?.temperature, 25.0)
            XCTAssertEqual(result?.conditionId, 800)
        }

        func testParseJSONHandlesInvalidData() {
            let json = Data("invalid json".utf8)
            let manager = WeatherManager()
            let result = manager.parseJSON(weatheData: json)
            XCTAssertNil(result)
        }

}
