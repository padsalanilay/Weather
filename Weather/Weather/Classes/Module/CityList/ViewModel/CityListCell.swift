//
//  CityListCell.swift
//  Weather
//
//  Created by Nilay Padsala on 5/24/19.
//  Copyright © 2019 Nilay Padsala. All rights reserved.
//

import UIKit

class CityListCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cityName.text = "Cle"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
