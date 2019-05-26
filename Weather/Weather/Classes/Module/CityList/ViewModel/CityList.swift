//
//  CityList.swift
//  Weather
//
//  Created by Nilay Padsala on 5/24/19.
//  Copyright © 2019 Nilay Padsala. All rights reserved.
//

import Foundation
import CoreLocation

extension CityListVC{
    
    func getAllCities(){
        if cityList.count == 0{
            let cities = [ "London", "Tokyo"]
            for city in cities{
                let newCity = City()
                newCity.name = city
                cityList.append(newCity)
            }
        }
        for city in cityList{
            getWeatherDetailsFor(city: city.name)
        }
        
    }
    
    func getWeatherDetailsFor(city: String){
        
        let cityWeatherDetailURL = "https://openweathermap.org/data/2.5/find?q=\(city)&units=\(self.messurement)&appid=b6907d289e10d714a6e88b30761fae22"
        
        urlDataRetriving.gatData(From: cityWeatherDetailURL) { (weatherData) in
        
            do {
                let jsonData = try JSONSerialization.jsonObject(with: weatherData, options: .mutableContainers) as! [String: Any]
                if (jsonData["cod"] != nil) && ((jsonData["cod"] as! String) == "200"){
                    let cityDetail = (jsonData["list"] as! [[String: Any]])[0]
                    let newCity = self.getCityFrom(data: cityDetail)
                    if let index = self.cityList.firstIndex(where: { $0.name == newCity.name }){
                        self.cityList[index] = newCity
                        DispatchQueue.main.async {
                            self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                        }
                    }
                    else{
                        self.cityList.append(newCity)
                        DispatchQueue.main.async {
                            self.tableView.insertRows(at: [IndexPath(row: self.cityList.count - 1, section: 0)], with: .automatic)
                        }
                    }
                    
                    
                }
            }
            catch{
                print("Problem in retriving data!)")
            }
            
        }

    }
    
    //MARK:- LocationManagerDelegate
    
    @IBAction func changeMeasurements(_ sender: Any) {
        if self.messurement == "Metric"{
            self.messurement = "Imperial"
        }
        else{
            self.messurement = "Metric"
        }
        self.getAllCities()
    }
    
    @IBAction func addCity(_ sender: Any) {
        print("new city")
    }
    
    func getWindDirectionFrom(degree: Int) -> String{
        if degree == 0 || degree == 360{
            return "N"
        }
        else if degree < 45{
            return "NNE"
        }
        else if degree == 45{
            return "NE"
        }
        else if degree < 90{
            return "ENE"
        }
        else if degree == 90{
            return "E"
        }
        else if degree < 135{
            return "ESE"
        }
        else if degree == 135{
            return "SE"
        }
        else if degree < 225{
            return "SSW"
        }
        else if degree == 225{
            return "SW"
        }
        else if degree < 270{
            return "WSW"
        }
        else if degree == 270{
            return "W"
        }
        else if degree < 315{
            return "WNW"
        }
        else if degree == 315{
            return "NW"
        }
        else if degree < 360{
            return "NNW"
        }
        else {
            return ""
        }
    }
    
    func getCityFrom(data: [String: Any]) -> City{
        let newCity = City()
        newCity.id = "\((data["id"] as! NSNumber))" //id
        newCity.name = (data["name"] as! String)// name
        
        let details = (data["main"] as! [String : Any])
        newCity.temperature = ("\((details["temp"] as! NSNumber))°") //temperature
        
        let weather = (data["weather"] as! [[String: Any]])[0]
        newCity.weatherDescription = (weather["description"] as! String)// weather description
        newCity.icon = (weather["icon"] as! String)//get image from url or display the default image here set it later
        
        //add weather details for perticular city like humidity, pressure, wind speed and direction, weather condition and value
        newCity.weather.append(["Humidity" : ("\((details["humidity"] as! NSNumber))%")])
        newCity.weather.append(["Pressure" : ("\((details["pressure"] as! NSNumber)) hPa")])
        
        let wind = (data["wind"] as! [String: Any])
        let windUnit = (self.messurement == "Metric") ? "m/s" : "m/h"
        newCity.weather.append(["Wind" : (getWindDirectionFrom(degree: (wind["deg"] as? Int) ?? -1) + " \((wind["speed"] as! NSNumber)) \(windUnit)")])
        
        var key = ""
        var value = ""
        if let rain = data["rain"] as? [String: Any]{
            key = "Rain"
            value = String((rain["3h"] as? Int) ?? 0) + "mm"
        }else if let snow = data["snow"] as? [String: Any]{
            key = "Snow"
            value = String((snow["3h"] as? Int) ?? 0) + "mm"
        }else if let clouds = data["clouds"] as? [String: Any]{
            key = "Clouds"
            value = String((clouds["all"] as? Int) ?? 0) + "%"
        }
        newCity.weather.append([key: value])
        
        return newCity
    }
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error) -> Void in
            if (error != nil) {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks != nil{
                let pm = placemarks![0]
                self.displayLocationInfo(placemark: pm)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        print("Error while updating location \(error?.localizedDescription ?? "")")
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        locationManager.stopUpdatingLocation()
        let city = placemark.locality ?? ""
        if !self.cityList.contains(where: { $0.name == city }){
            self.getWeatherDetailsFor(city: city)
        }
        
    }
}
