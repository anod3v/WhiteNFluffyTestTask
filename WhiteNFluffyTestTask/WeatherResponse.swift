//
//  WeatherResponse.swift
//  WhiteNFluffyTestTask
//
//  Created by Andrey on 02/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable { // TODO: to update
    
    let fact: Fact
    let forecasts: [Forecast]
    
}

struct Fact: Codable {
    
    let temp: Int
    let feelsLike: Int
    let condition: String
    let icon: String
    let windSpeed: Double
    let windDirection: String
    let pressure: Int
    let humidity: Int
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case condition
        case icon
        case windSpeed = "wind_speed"
        case windDirection = "wind_dir"
        case pressure = "pressure_mm"
        case humidity
    }
    
}

struct Forecast: Codable {

    let parts: Parts
    
}

struct Parts: Codable {
    
    let day: Day
    let evening: Evening
    
}

struct Day: Codable {
    
    let tempMin: Int
    let tempMax: Int
    let condition: String
    
    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case condition
    }
    
}

struct Evening: Codable {
    
    let tempMin: Int
    let tempMax: Int
    let condition: String
    
    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case condition
    }
    
}
