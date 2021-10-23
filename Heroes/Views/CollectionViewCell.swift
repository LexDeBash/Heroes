//
//  CollectionViewCell.swift
//  Heroes
//
//  Created by Alexey Efimov on 22.10.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 15
        }
    }
    
    func configure(with superhero: Superhero) {
        mainLabel.text = superhero.name
        guard let url = URL(string: superhero.images.lg) else { return }
        NetworkManager.shared.fetchImageData(from: url) { result in
            switch result {
            case .success(let imageData):
                self.imageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
