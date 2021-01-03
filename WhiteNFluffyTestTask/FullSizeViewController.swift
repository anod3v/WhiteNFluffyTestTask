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
        label.numberOfLines = 1
        label.sizeToFit()
        label.backgroundColor = .green
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var temperatureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.backgroundColor = .green
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var temperatureFeelsLikeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.backgroundColor = .green
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var humidityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit() // TODO: check if required
        label.backgroundColor = .green
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var weatherIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .systemOrange
        
        view.translatesAutoresizingMaskIntoConstraints = false
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
        view.addSubview(temperatureLabel)
        view.addSubview(temperatureFeelsLikeLabel)
        view.addSubview(weatherIcon)
        view.addSubview(humidityLabel)
    }
    
    func configureViews() {
        guard let weatherItem = self.weatherItem else { return }
        cityNameLabel.text = weatherItem.name
        temperatureLabel.text = "\(weatherItem.weatherResponse.fact.temp)"
        temperatureFeelsLikeLabel.text = "\(weatherItem.weatherResponse.fact.feelsLike)"
        weatherIcon.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let iconURL = "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weatherItem.weatherResponse.fact.icon).svg"
        weatherIcon.sd_setImage(with: URL(string: iconURL), placeholderImage: UIImage(named: "placeholder.png"))
        humidityLabel.text = "\(weatherItem.weatherResponse.fact.humidity)"
    }
    
    func updateConstraints() {
        NSLayoutConstraint.activate([ // TODO: to put constants
            cityNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            cityNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 10),
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            temperatureFeelsLikeLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor),
            temperatureFeelsLikeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            weatherIcon.topAnchor.constraint(equalTo: temperatureFeelsLikeLabel.bottomAnchor),
            weatherIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            weatherIcon.widthAnchor.constraint(equalToConstant: 200),
            weatherIcon.heightAnchor.constraint(equalTo: weatherIcon.widthAnchor),
            
            humidityLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 10),
            humidityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        
    }
}
