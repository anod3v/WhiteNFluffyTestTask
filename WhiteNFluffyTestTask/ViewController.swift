//
//  ViewController.swift
//  WhiteNFluffyTestTask
//
//  Created by Andrey on 02/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import UIKit
import PromiseKit

class ViewController: UIViewController {
    
    let weatherService = WeatherService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        weatherService.getWeatherWithCityName(cityName: "Москва").done { response in
            debugPrint("\(response)")
        }
    }

}

