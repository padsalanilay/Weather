//
//  City.swift
//  Weather
//
//  Created by Nilay Padsala on 5/25/19.
//  Copyright © 2019 Nilay Padsala. All rights reserved.
//

import UIKit

class City: NSObject {
    var id: String!
    var name: String!
    var temperature: String!
    var weatherDescription: String!
//    var lat: String!
//    var long: String!
//    var country: String!
    var icon: UIImage!
    var weather = [[String:String]]() // humadity, pressure, wind speed, wether value
}
