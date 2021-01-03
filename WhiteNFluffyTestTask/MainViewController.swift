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
    
    var cityNames = [
        "Вологда",
         "Пермь",
        "Самара",
//        "Севастополь",
//        "Киев",
//        "Орел",
//        "Минск",
//        "Москва",
//        "Казань"
    ]
    
    var weatherItems = [WeatherItem]()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Поиск города"
        
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
        setupViews()
        //        weatherService.getWeatherByCityName(cityName: "Москва").done { response in
        //            debugPrint("\(response)")
        //        }
        cityNames.forEach({
            let cityName = $0
            weatherService.getWeatherByCityName(cityName: cityName)
                .done { response in
                    self.weatherItems.append(WeatherItem(name: cityName, weatherResponse: response))
                    debugPrint(response)
                    DispatchQueue.main.async { self.tableView.reloadData() } // TODO: to provide with better solution
            }.catch { error in
                debugPrint(error.localizedDescription)
            }
        })
        
    }
    
    func prepareToShowFullSize(cityName: String) {
        guard !cityNames.contains(cityName) else { return } // TODO: improve
        weatherService.getWeatherByCityName(cityName: cityName)
        .done { response in
            let fullSizeViewController = FullSizeViewController()
            fullSizeViewController.weatherItem = WeatherItem(name: cityName, weatherResponse: response)
            DispatchQueue.main.async {
                self.present(fullSizeViewController, animated: true, completion: nil)
            }
        }
    }
    
    func setupViews() {
        self.view.addSubview(tableView)
        self.view.addSubview(searchBar)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        updateConstraints()
    }
    
    func updateConstraints() {
        NSLayoutConstraint.activate([ // TODO: add to the tableView header
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])

    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseId, for: indexPath) as! MainTableViewCell
        let weatherItem = weatherItems[indexPath.row]
        cell.configure(weatherItem: weatherItem)
        return cell
    }
    
    
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let weatherItem = searchBar.text?.capitalized, !weatherItem.isEmpty {
            prepareToShowFullSize(cityName: String)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
}

