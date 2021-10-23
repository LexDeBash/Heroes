//
//  CollectionViewCell.swift
//  Heroes
//
//  Created by Alexey Efimov on 22.10.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var imageView: SuperheroImageView! {
        didSet {
            imageView.layer.cornerRadius = 15
        }
    }
    
    func configure(with superhero: Superhero) {
        mainLabel.text = superhero.name
        imageView.fetchImage(from: superhero.images.lg)
        /*
        DispatchQueue.global().async {
            guard let imageURL = URL(string: superhero.images.sm) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        }
        */
    }
}
