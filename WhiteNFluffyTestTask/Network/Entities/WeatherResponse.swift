//
//  WeatherResponse.swift
//  WhiteNFluffyTestTask
//
//  Created by Andrey on 02/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    
    let fact: Fact
    
}

struct Fact: Codable {
    
    let temperature: Int
    let temperatureFeelsLike: Int
    let icon: String
    let pressure: Int
    let humidity: Int
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureFeelsLike = "feels_like"
        case icon = "icon"
        case pressure = "pressure_mm"
        case humidity = "humidity"
    }
    
}
