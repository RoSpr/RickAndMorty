//
//  CharacterModel.swift
//  Skillbox-1.12
//
//  Created by Rodion on 24.09.2021.
//

import Foundation

class CharacterModel {
    let name: String
    let status: String
    let species: String
    let gender: String
    
    let locationDict: NSDictionary
    let imageURL: String
    let episodes: [String]
    
    init?(data: NSDictionary) {
        guard let name = data["name"] as? String,
              let status = data["status"] as? String,
              let species = data["species"] as? String,
              let gender = data["gender"] as? String,
              let locationDict = data["location"] as? NSDictionary,
              let imageURL = data["image"] as? String,
              let episodes = data["episode"] as? [String] else { return nil }
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.locationDict = locationDict
        self.imageURL = imageURL
        self.episodes = episodes
    }
}
