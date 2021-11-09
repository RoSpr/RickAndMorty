//
//  WebLoader.swift
//  Skillbox-1.12
//
//  Created by Rodion on 24.09.2021.
//

import Foundation
import Alamofire

protocol WebLoaderPagesDelegate: AnyObject {
    func tellNextAndPreviousPages(previousPage: String?, nextPage: String?, numberOfPages: Int?)
}

class WebLoader {
    weak var delegate: WebLoaderPagesDelegate?
    
//MARK: - Функция загрузки основной информации о персонажах
    func loadCharacter(delegate: ViewController, url: String, completion: @escaping ([CharacterModel]) -> Void) {
        self.delegate = delegate
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let parsedData = ParsedData(json: value as! NSDictionary) {
                    //MARK: - Передача ссылок на предыдущую и следующую страницы
                    self.delegate?.tellNextAndPreviousPages(
                        previousPage: parsedData.info["prev"] as? String,
                        nextPage: parsedData.info["next"] as? String,
                        numberOfPages: parsedData.info["pages"] as? Int)
                    
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
                print("Error in WebLoader.loadCharacter: \n\(error)")
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
                case .failure(let error):
                    print("Error in WebLoader.loadEpisodes: \n\(error)")
                }
            }
        }
    }
}

