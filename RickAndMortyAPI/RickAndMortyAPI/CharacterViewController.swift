//
//  CharacterViewController.swift
//  Skillbox-1.12
//
//  Created by Rodion on 24.09.2021.
//

import UIKit
import MBProgressHUD

class CharacterViewController: UIViewController {
    
    @IBOutlet weak var EpisodesTableView: UITableView!
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesAndGenderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var firstEpisodeLabel: UILabel!
    
    var episodes: [EpisodeModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.EpisodesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showHUD(for: self.view)
        
        EpisodesTableView.dataSource = self
        EpisodesTableView.delegate = self
    }
    
//MARK: - Функция обновления данных в лейблах и вью; вызывается перед отображением экрана
    func updateCharacterData(imageURL: String, name: String, status: String, species: String, gender: String, location: String, firstEpisode: String) {
        
        DispatchQueue.main.async { [self] in
            if let url = URL(string: imageURL) {
                if let imageData = try? Data(contentsOf: url) {
                    characterImageView.image = UIImage(data: imageData)
                }
            }
            
            nameLabel.text = name

            switch status {
            case "Alive":
                statusView.backgroundColor = .green
            case "Dead":
                statusView.backgroundColor = .red
            default:
                statusView.backgroundColor = .gray
            }
            
            statusLabel.text = status
            speciesAndGenderLabel.text = "\(species) (\(gender))"
            locationLabel.text = location
            firstEpisodeLabel.text = firstEpisode
        }
    }
    
    func fetchEpisodes(episodes: [EpisodeModel]) {
        self.episodes = episodes
    }
}

//MARK: - Стандартные расширения для TableView
extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodesTableViewCell", for: indexPath) as! EpisodesTableViewCell
        cell.updateCellLabels(episodeName: episodes[indexPath.row].name, episodeNumber: episodes[indexPath.row].episode)
        dismissHUD(for: self.view)
        
        return cell
    }
    
    
}

extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


//MARK: - Функции отображения и сокрытия процесса загрузки
extension CharacterViewController {
    func showHUD(for view: UIView) {
        DispatchQueue.main.async {
            let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
            progressHUD.label.text = "Loading"
        }
    }
    
    func dismissHUD(for view: UIView) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
}
