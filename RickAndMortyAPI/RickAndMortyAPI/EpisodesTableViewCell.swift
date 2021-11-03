//
//  EpisodesTableViewCell.swift
//  Skillbox-1.12
//
//  Created by Rodion on 26.09.2021.
//

import UIKit

class EpisodesTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    
    func updateCellLabels(episodeName: String, episodeNumber: String) {
        episodeNameLabel.text = episodeName
        episodeNumberLabel.text = episodeNumber
    }

}
