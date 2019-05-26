//
//  WeatherDetailsVC.swift
//  Weather
//
//  Created by Nilay Padsala on 5/24/19.
//  Copyright © 2019 Nilay Padsala. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class WeatherDetailsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    private let weatherMainDetailCellIdentifier = "weatherMainDetailCell"
    private let weatherForecastCellIdentifier = "weatherForecastCell"
    
    var city = City()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(WeatherMainDetailCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weatherMainDetailCellIdentifier, for: indexPath) as! WeatherMainDetailCell
            cell.lblCity.text = self.city.name
            cell.lblWeather.text = self.city.weatherDescription
            cell.lblTemperature.text = self.city.temperature
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weatherForecastCellIdentifier, for: indexPath) as! WeatherForecastCell
            cell.details = self.city.weather[indexPath.row - 1]
            return cell
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0{
            return CGSize(width: self.collectionView.bounds.size.width, height: 184)
        }
        else{
            return CGSize(width: self.collectionView.bounds.size.width / 2, height: 80)
        }
    }

}
