//
//  ViewController.swift
//  Skillbox-1.12
//
//  Created by Rodion on 24.09.2021.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {
    var characters: [CharacterModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.characterTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var characterTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showHUD()
        
        characterTableView.dataSource = self
        characterTableView.delegate = self
        
        WebLoader().loadCharacter { characters in
            self.characters = characters
            self.dismissHUD()
        }
    }
}


//MARK: - Стандартные расширения для TableView
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell
        
        let character = characters[indexPath.row]
        if let location = LocationModel(locationDict: character.locationDict) {
            cell.updateCharacterCell(imageURL: character.imageURL, name: character.name, status: character.status, location: location.location)
        } else {
            cell.updateCharacterCell(imageURL: character.imageURL, name: character.name, status: character.status, location: "Undefined")
        }
        
        cell.roundImageViewCorners()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = self.view.frame.width
        return width / 2.5
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "CharacterViewController") as! CharacterViewController
        
        let character = characters[indexPath.row]
        
        if let location = LocationModel(locationDict: character.locationDict) {
                WebLoader().loadEpisodes(urls: character.episodes) { parsedEpisodes in
                    controller.fetchEpisodes(episodes: parsedEpisodes)
                    controller.updateCharacterData(imageURL: character.imageURL, name: character.name, status: character.status, species: character.species, gender: character.gender, location: location.location, firstEpisode: parsedEpisodes.first?.name ?? "?")
            }
        } else {
            WebLoader().loadEpisodes(urls: character.episodes) { parsedEpisodes in
                controller.fetchEpisodes(episodes: parsedEpisodes)
                controller.updateCharacterData(imageURL: character.imageURL, name: character.name, status: character.status, species: character.species, gender: character.gender, location: "Undefined", firstEpisode: parsedEpisodes.first?.name ?? "?")
            }
        }
        
        self.present(controller, animated: true, completion: nil)
    }
}

//MARK: - Функции отображения и сокрытия процесса загрузки
extension ViewController {
    func showHUD() {
        DispatchQueue.main.async {
            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD.label.text = "Loading"
        }
    }
    
    func dismissHUD() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}

