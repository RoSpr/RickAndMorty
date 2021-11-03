//
//  WebLoader.swift
//  Skillbox-1.12
//
//  Created by Rodion on 24.09.2021.
//

import Foundation
import Alamofire

class WebLoader {
//MARK: - Функция загрузки основной информации о пресонажах
    func loadCharacter(completion: @escaping ([CharacterModel]) -> Void) {
        AF.request("https://rickandmortyapi.com/api/character").responseJSON { response in
            switch response.result {
            case .success(let value):
                if let parsedData = ParsedData(json: value as! NSDictionary) {
                    DispatchQueue.main.async {
                        var characters: [CharacterModel] = []
                        for model in parsedData.results {
                            if let character = CharacterModel(data: model) {
                                characters.append(character)
                            }
                        }
                        DispatchQueue.global().async {
                            completion(characters)
                        }
                    }
                } else {
                    return
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
//MARK: - Функция загрузки эпизодов для конкретного персонажа
    func loadEpisodes(urls: [String], completion: @escaping ([EpisodeModel]) -> Void) {
        var episodes: [EpisodeModel] = []
        for url in urls {
            AF.request(url).responseJSON { response in
                switch response.result {
                case .success(let value):
                    DispatchQueue.main.async {
                        if let episode = EpisodeModel(episode: value as! NSDictionary) {
                            episodes.append(episode)
                        }
                        completion(episodes)
                    }
                default: return
                }
            }
        }
    }
}
