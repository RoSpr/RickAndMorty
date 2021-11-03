//
//  CharacterTableViewCell.swift
//  Skillbox-1.12
//
//  Created by Rodion on 24.09.2021.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
//MARK: - Функция обновления данных в лейблах и вью
    func updateCharacterCell(imageURL: String, name: String, status: String, location: String) {
        DispatchQueue.main.async { [self] in
            if let url = URL(string: imageURL) {
                if let imageData = try? Data(contentsOf: url) {
                    characterImageView.image = UIImage(data: imageData)
                }
            }
            
            characterNameLabel.text = name

            switch status {
            case "Alive":
                statusView.backgroundColor = .green
            case "Dead":
                statusView.backgroundColor = .red
            default:
                statusView.backgroundColor = .gray
            }
            statusLabel.text = status
            locationLabel.text = location
        }
    }
    
    func roundImageViewCorners() {
        characterImageView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 9.0)
    }

}

//MARK: - Закругление левых верхнего и нижнего краев вью с иконкой персонажа
extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
}
