//
//  WeatherForecastCell.swift
//  Weather
//
//  Created by Nilay Padsala on 5/24/19.
//  Copyright © 2019 Nilay Padsala. All rights reserved.
//

import UIKit

class WeatherForecastCell: UICollectionViewCell {
    @IBOutlet weak var lblWeatherType: UILabel!
    @IBOutlet weak var lblWeatherData: UILabel!
    
    private var cellDetails = [String: String]()
    
    var details : [String: String]{
        set(newDetails){
            self.cellDetails = newDetails
            let key = Array(self.details.keys)[0]
            lblWeatherType.text = key
            lblWeatherData.text = self.cellDetails[key]
        }
        get{
            return self.cellDetails
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
