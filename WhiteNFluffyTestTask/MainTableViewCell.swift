//
//  MainTableViewCell.swift
//  WhiteNFluffyTestTask
//
//  Created by Andrey on 02/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import UIKit
import SDWebImage

class MainTableViewCell: UITableViewCell {
    
    static let reuseId: String = "MainTableViewCell"
    
    private(set) var cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.extraBoldOfSize18
        label.numberOfLines = 1
        label.sizeToFit()
        label.backgroundColor = .green
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.extraBoldOfSize18
        label.numberOfLines = 1
        label.backgroundColor = .cyan
        
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.contentView.backgroundColor = .brown
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(weatherIcon)
    }
    
    func configure(weatherItem: WeatherItem) {
        cityNameLabel.text = weatherItem.name
        temperatureLabel.text = "\(weatherItem.weatherResponse.fact.temp)"
        weatherIcon.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let iconURL = "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weatherItem.weatherResponse.fact.icon).svg"
        weatherIcon.sd_setImage(with: URL(string: iconURL), placeholderImage: UIImage(named: "placeholder.png"))

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            cityNameLabel.centerYAnchor.constraint(equalTo: weatherIcon.centerYAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cityNameLabel.widthAnchor.constraint(equalToConstant: 200),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            temperatureLabel.centerYAnchor.constraint(equalTo: weatherIcon.centerYAnchor),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 100),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 50),
            temperatureLabel.trailingAnchor.constraint(equalTo: weatherIcon.leadingAnchor, constant: -20),
            
            weatherIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            weatherIcon.widthAnchor.constraint(equalToConstant: 100),
            weatherIcon.heightAnchor.constraint(equalToConstant: 100),
            weatherIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            weatherIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
