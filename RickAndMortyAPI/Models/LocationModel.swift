//
//  LocationModel.swift
//  Skillbox-1.12
//
//  Created by Rodion on 24.09.2021.
//

import Foundation

class LocationModel {
    let location: String
    
    init?(locationDict: NSDictionary) {
        guard let location = locationDict["name"] as? String else { return nil }
        
        self.location = location
    }
}
