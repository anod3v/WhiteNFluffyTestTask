//
//  ViewController.swift
//  WhiteNFluffyTestTask
//
//  Created by Andrey on 02/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import UIKit
import PromiseKit

class CitiesListViewController: UIViewController {
    
    var rootView = CitiesListMainView()
    
    var cityNames = [ "Вологда", "Пермь", "Самара", "Тула", "Киев", "Орел", "Минск", "Москва", "Казань", "Момбаса"]
    
    var weatherItems = [WeatherItem]()
    
    let weatherService = WeatherService()
    
    init() {
        super.init(nibName: .none, bundle: .none)
        setupViews()
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
        //        weatherService.getWeatherByCityName(cityName: "Москва").done { response in
        //            debugPrint("\(response)")
        //        }
        cityNames.forEach({
            let cityName = $0
            weatherService.getWeatherByCityName(cityName: cityName)
                .done { response in
                    self.weatherItems.append(WeatherItem(name: cityName, weatherResponse: response))
                    debugPrint(response)
                    DispatchQueue.main.async { self.rootView.tableView.reloadData() } // TODO: to provide with better solution
            }.catch { error in
                debugPrint(error.localizedDescription)
            }
        })
        
        weatherService.locationService.locationErrorCallback = { [weak self] locationError in
        guard let self = self else { return }
            AlertService.showLocationNotFoundAlert(viewController: self)
    }
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
        rootView.searchBar.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
        rootView.tableView.register(CitiesListTableViewCell.self, forCellReuseIdentifier: CitiesListTableViewCell.reuseId)
        rootView.tableView.estimatedRowHeight = 100
        rootView.tableView.rowHeight = UITableView.automaticDimension
    }
    
}

extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CitiesListTableViewCell.reuseId, for: indexPath) as! CitiesListTableViewCell
        cell.selectionStyle = .none
        let weatherItem = weatherItems[indexPath.row]
        cell.configure(weatherItem: weatherItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fullSizeViewController = FullSizeViewController()
        fullSizeViewController.weatherItem = weatherItems[indexPath.row]
        self.present(fullSizeViewController, animated: true, completion: nil)
    }
    
    
}

extension CitiesListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let cityName = searchBar.text?.capitalized, !cityName.isEmpty {
            prepareToShowFullSize(cityName: cityName)
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

