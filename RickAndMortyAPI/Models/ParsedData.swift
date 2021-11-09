//
//  ParsedData.swift
//  Skillbox-1.12
//
//  Created by Rodion on 24.09.2021.
//

import Foundation

class ParsedData {
    let info: NSDictionary
    let results: [NSDictionary]
    
    init?(json: NSDictionary) {
        guard let info = json["info"] as? NSDictionary,
              let results = json["results"] as? [NSDictionary] else {return nil}
        self.info = info
        self.results = results
    }
}
