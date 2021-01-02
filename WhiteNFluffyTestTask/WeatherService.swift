//
//  WeatherService.swift
//  WhiteNFluffyTestTask
//
//  Created by Andrey on 02/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import Foundation
import PromiseKit
import CoreLocation

class WeatherService: NetworkService {
    
    let locationService = LocationService()
    
    private func getWeatherByCityLocation(coordinate: CLLocationCoordinate2D) -> Promise<WeatherResponse> {
        return self.makeRequest(method: "informers", queryItems: [
            .init(name: "lat", value: "\(coordinate.latitude)"),
            .init(name: "lon", value: "\(coordinate.longitude)")
        ])
    }
    
    func getWeatherByCityName(cityName: String) -> Promise<WeatherResponse> {
        firstly{
        locationService.getCoordinateFrom(address: cityName)
        }.then { location in
            self.getWeatherByCityLocation(coordinate: location)
        }
    }
}
