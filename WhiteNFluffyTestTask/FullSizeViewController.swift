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
    
    private(set) var cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.extraBoldOfSize25
        label.numberOfLines = 1
        label.sizeToFit()
//        label.backgroundColor = .green
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.extraBoldOfSize25
        label.textColor = .white
        label.numberOfLines = 1
        label.sizeToFit()
//        label.backgroundColor = .green
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var temperatureFeelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.regularOfSize16
        label.numberOfLines = 1
        label.sizeToFit()
//        label.backgroundColor = .green
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var humidityLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.regularOfSize16
        label.numberOfLines = 1
        label.sizeToFit() // TODO: check if required
//        label.backgroundColor = .green
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var pressureLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.regularOfSize16
        label.numberOfLines = 1
        label.sizeToFit() // TODO: check if required
//        label.backgroundColor = .green
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var weatherIcon: RoundCornersImageView = {
            let view = RoundCornersImageView(frame: .zero)
    //        view.contentMode = .scaleAspectFill
            view.backgroundColor = #colorLiteral(red: 1, green: 0.3864146769, blue: 0.4975627065, alpha: 1)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            return view
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        updateConstraints()
        configureViews()
    }
    
    func addSubviews() {
        view.addSubview(cityNameLabel)
        view.addSubview(temperatureFeelsLikeLabel)
        view.addSubview(weatherIcon)
        view.addSubview(temperatureLabel)
        view.addSubview(humidityLabel)
        view.addSubview(pressureLabel)
    }
    
    func configureViews() {
        guard let weatherItem = self.weatherItem else { return }
        cityNameLabel.text = weatherItem.name
        switch weatherItem.weatherResponse.fact.temp {
        case _ where weatherItem.weatherResponse.fact.temp > 0:
            temperatureLabel.text = "+\(weatherItem.weatherResponse.fact.temp) ℃"
        default:
            temperatureLabel.text = "\(weatherItem.weatherResponse.fact.temp) ℃"
        }
        temperatureFeelsLikeLabel.text = "ощущается как \(weatherItem.weatherResponse.fact.feelsLike) ℃"
        weatherIcon.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let iconURL = "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weatherItem.weatherResponse.fact.icon).svg"
        weatherIcon.sd_setImage(with: URL(string: iconURL), placeholderImage: UIImage(named: "placeholder.png"))
        humidityLabel.text = "влажность \(weatherItem.weatherResponse.fact.humidity) %"
        pressureLabel.text = "давление \(weatherItem.weatherResponse.fact.pressure) мм"
    }
    
    func updateConstraints() {
        NSLayoutConstraint.activate([ // TODO: to put constants
            cityNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 4),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            temperatureLabel.centerYAnchor.constraint(equalTo: weatherIcon.centerYAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: weatherIcon.centerXAnchor),
            
            weatherIcon.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 20),
            weatherIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherIcon.widthAnchor.constraint(equalToConstant: 200),
            weatherIcon.heightAnchor.constraint(equalTo: weatherIcon.widthAnchor),
            
            temperatureFeelsLikeLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 20),
            temperatureFeelsLikeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            humidityLabel.topAnchor.constraint(equalTo: temperatureFeelsLikeLabel.bottomAnchor, constant: 20),
            humidityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            pressureLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 20),
            pressureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        
    }
}
