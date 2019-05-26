//
//  CityListCell.swift
//  Weather
//
//  Created by Nilay Padsala on 5/24/19.
//  Copyright © 2019 Nilay Padsala. All rights reserved.
//

import UIKit

class CityListCell: UITableViewCell {

    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblCityTemperature: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    private var cellCity = City()
    var city: City{
        set(newCity){
            self.cellCity = newCity
            self.lblCityName.text = newCity.name ?? ""
            self.lblCityTemperature.text = newCity.temperature ?? ""
        }
        get{
            return self.cellCity
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
