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
    
    var cities = ["Москва", "Казань", "Краснодар", "Вологда", "Пермь", "Самара", "Севастополь", "Киев", "Орел", "Минск"]
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Введите город..."
        
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
        weatherService.getWeatherWithCityName(cityName: "Москва").done { response in
            debugPrint("\(response)")
        }
    }

}

extension MainViewController: UISearchBarDelegate {
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MainTableViewCell.self), for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        let city = cities[indexPath.row]
        cell.configure(city: String)
        return cell
    }
    
    
}

