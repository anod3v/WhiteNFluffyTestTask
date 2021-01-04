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
        label.font = Fonts.semiBoldOfSize25
        label.numberOfLines = 1
        label.sizeToFit()
//        label.backgroundColor = .green
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.extraBoldOfSize25
        label.numberOfLines = 1
        label.textAlignment = .center
//        label.backgroundColor = .cyan
        
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
        switch weatherItem.weatherResponse.fact.temperature {
        case _ where weatherItem.weatherResponse.fact.temperature > 0:
            temperatureLabel.text = "+\(weatherItem.weatherResponse.fact.temperature) ℃"
        default:
            temperatureLabel.text = "\(weatherItem.weatherResponse.fact.temperature) ℃"
        }
        weatherIcon.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let iconURL = "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weatherItem.weatherResponse.fact.icon).svg"
        weatherIcon.sd_setImage(with: URL(string: iconURL), placeholderImage: UIImage(named: "placeholder.png"))

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            cityNameLabel.centerYAnchor.constraint(equalTo: weatherIcon.centerYAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacings.ofSize20 * 2),
            cityNameLabel.widthAnchor.constraint(equalToConstant: Spacings.ofSize100 * 2),
            cityNameLabel.heightAnchor.constraint(equalToConstant: Spacings.ofSize20 * 2),
            
            temperatureLabel.centerYAnchor.constraint(equalTo: weatherIcon.centerYAnchor),
            temperatureLabel.widthAnchor.constraint(equalToConstant: Spacings.ofSize100),
            temperatureLabel.heightAnchor.constraint(equalToConstant: Spacings.ofSize20 * 2),
            temperatureLabel.trailingAnchor.constraint(equalTo: weatherIcon.leadingAnchor, constant: -Spacings.ofSize20),
            
            weatherIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacings.ofSize20),
            weatherIcon.widthAnchor.constraint(equalToConstant: Spacings.ofSize100),
            weatherIcon.heightAnchor.constraint(equalToConstant: Spacings.ofSize100),
            weatherIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacings.ofSize20 * 2),
            weatherIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Spacings.ofSize20)
        ])
    }
}
