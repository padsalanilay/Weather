//
//  URLDataRetriving.swift
//  Weather
//
//  Created by Nilay Padsala on 5/25/19.
//  Copyright © 2019 Nilay Padsala. All rights reserved.
//

import UIKit

class URLDataRetriving: NSObject {
    
    override init() {
        super.init()
    }
    
    func gatData(From url: String, completionHandler: @escaping (_ data:Data) -> Void){
        let url = URL(string: url.replacingOccurrences(of: " ", with: "%20"))
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print(error!)
            }
            else{
                if let content = data{
                    completionHandler(content)
                }
            }
        }
        task.resume()
    }
}
