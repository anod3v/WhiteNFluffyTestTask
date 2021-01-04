//
//  FullSizeMainView.swift
//  WhiteNFluffyTestTask
//
//  Created by Andrey on 05/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import UIKit

class FullSizeMainView: UIView {
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
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setNeedsUpdateConstraints()
    }
    
    func addSubviews() {
        self.addSubview(cityNameLabel)
        self.addSubview(temperatureFeelsLikeLabel)
        self.addSubview(weatherIcon)
        self.addSubview(temperatureLabel)
        self.addSubview(humidityLabel)
        self.addSubview(pressureLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
    NSLayoutConstraint.activate([
        cityNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: self.frame.height / 4),
        cityNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
        temperatureLabel.centerYAnchor.constraint(equalTo: weatherIcon.centerYAnchor),
        temperatureLabel.centerXAnchor.constraint(equalTo: weatherIcon.centerXAnchor),
        
        weatherIcon.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: Spacings.ofSize20),
        weatherIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        weatherIcon.widthAnchor.constraint(equalToConstant: Spacings.ofSize100 * 2),
        weatherIcon.heightAnchor.constraint(equalTo: weatherIcon.widthAnchor),
        
        temperatureFeelsLikeLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: Spacings.ofSize20),
        temperatureFeelsLikeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
        humidityLabel.topAnchor.constraint(equalTo: temperatureFeelsLikeLabel.bottomAnchor, constant: Spacings.ofSize20),
        humidityLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
        pressureLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: Spacings.ofSize20),
        pressureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    ])
        super.updateConstraints()
    }
}
