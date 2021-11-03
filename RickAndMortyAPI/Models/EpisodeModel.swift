//
//  EpisodeModel.swift
//  Skillbox-1.12
//
//  Created by Rodion on 25.09.2021.
//

import Foundation

class EpisodeModel {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    init?(episode: NSDictionary) {
        guard let id = episode["id"] as? Int,
              let name = episode["name"] as? String,
              let air_date = episode["air_date"] as? String,
              let episodeNumber = episode["episode"] as? String,
              let characters = episode["characters"] as? [String],
              let url = episode["url"] as? String,
              let created = episode["created"] as? String else { return nil }
        self.id = id
        self.name = name
        self.air_date = air_date
        self.episode = episodeNumber
        self.characters = characters
        self.url = url
        self.created = created
    }
}
