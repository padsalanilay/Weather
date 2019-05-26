//
//  CityListVC.swift
//  Weather
//
//  Created by Nilay Padsala on 5/24/19.
//  Copyright © 2019 Nilay Padsala. All rights reserved.
//

import UIKit

class CityListVC: UITableViewController {

    private let cellIdentifier = "cityListCellIdentifier"
    private let weatherDetailsSegueIdentifier = "displayWeatherDetails"
    
    var messurement = "Metric" //Metric for celcius and Imperial for Fahrenheit
    var cityList = [City]()
    let urlDataRetriving = URLDataRetriving()
    var dataToPass = -1

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAllCities()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CityListCell
        cell.city = cityList[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cityList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if cityList[indexPath.row].id != nil{
            self.dataToPass = indexPath.row
            performSegue(withIdentifier: weatherDetailsSegueIdentifier, sender: self)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! WeatherDetailsVC
        destination.city = cityList[dataToPass]
    }

}
