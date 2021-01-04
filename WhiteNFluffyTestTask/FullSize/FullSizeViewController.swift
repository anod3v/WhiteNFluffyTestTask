//
//  FullSizeViewController.swift
//  WhiteNFluffyTestTask
//
//  Created by Andrey on 03/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import UIKit
import SDWebImage

class FullSizeViewController: UIViewController {
    
    var weatherItem: WeatherItem?
    
    var rootView = FullSizeMainView()
    
    init() {
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureViews()
    }
    
    func configureViews() {
        guard let weatherItem = self.weatherItem else { return }
        rootView.cityNameLabel.text = weatherItem.name
        switch weatherItem.weatherResponse.fact.temperature {
        case _ where weatherItem.weatherResponse.fact.temperature > 0:
            rootView.temperatureLabel.text = "+\(weatherItem.weatherResponse.fact.temperature) ℃"
        default:
            rootView.temperatureLabel.text = "\(weatherItem.weatherResponse.fact.temperature) ℃"
        }
        rootView.temperatureFeelsLikeLabel.text = "ощущается как \(weatherItem.weatherResponse.fact.temperatureFeelsLike) ℃"
        rootView.weatherIcon.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let iconURL = "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weatherItem.weatherResponse.fact.icon).svg"
        rootView.weatherIcon.sd_setImage(with: URL(string: iconURL), placeholderImage: UIImage(named: "placeholder.png"))
        rootView.humidityLabel.text = "влажность \(weatherItem.weatherResponse.fact.humidity) %"
        rootView.pressureLabel.text = "давление \(weatherItem.weatherResponse.fact.pressure) мм"
    }
}
