//
//  ViewController.swift
//  WhiteNFluffyTestTask
//
//  Created by Andrey on 02/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import UIKit
import PromiseKit

class MainViewController: UIViewController {
    
    var cityNames = ["Краснодар"
        , "Вологда"
//        , "Пермь", "Самара", "Севастополь", "Киев", "Орел", "Минск", "Москва", "Казань"
    ]
    
    var weatherItems = [WeatherItem]()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Укажите город..."
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseId)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupTableView()
        //        weatherService.getWeatherByCityName(cityName: "Москва").done { response in
        //            debugPrint("\(response)")
        //        }
        cityNames.forEach({
            let cityName = $0
            weatherService.getWeatherByCityName(cityName: cityName)
                .done { response in
                    self.weatherItems.append(WeatherItem(name: cityName, weatherResponse: response))
                    debugPrint(response)
            }.catch { error in
                debugPrint(error.localizedDescription)
            }
        })
        
    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
        updateConstraints()
    }
    
    func updateConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])

    }
    
}

extension MainViewController: UISearchBarDelegate {
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MainTableViewCell.self), for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        let weatherItem = weatherItems[indexPath.row]
        cell.configure(weatherItem: weatherItem)
        return cell
    }
    
    
}

