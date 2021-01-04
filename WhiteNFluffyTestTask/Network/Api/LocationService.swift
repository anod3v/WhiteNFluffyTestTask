//
//  LocationService.swift
//  WhiteNFluffyTestTask
//
//  Created by Andrey on 02/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import Foundation
import CoreLocation
import PromiseKit

class LocationService {
    
    var locationErrorCallback: ((Error) -> Void)?
    
    func getCoordinateFrom(address: String) -> Promise<CLLocationCoordinate2D> {
        
        return Promise { seal in
            CLGeocoder().geocodeAddressString(address, completionHandler: { (placemarks, error) -> Void in
                if let error = error {
                    seal.reject(error)
                    debugPrint(error)
                    if let callback = self.locationErrorCallback {
                        callback(error)
                    }
                }
                if let placemark = placemarks?.first {
                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                    seal.fulfill(coordinates)
                    debugPrint(coordinates)
                }
            })
            
        }
    }
}
