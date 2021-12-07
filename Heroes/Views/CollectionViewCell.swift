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
    
    private var activityIndicator: UIActivityIndicatorView?
    
    private var imageURL: URL? {
        didSet {
            imageView.image = nil
            updateImage()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator = showSpinner(in: imageView)
    }
    
    func configure(with superhero: Superhero) {
        mainLabel.text = superhero.name
        imageURL = URL(string: superhero.images.lg)
    }
    
    private func updateImage() {
        guard let url = imageURL else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                if url == self.imageURL {
                    self.activityIndicator?.stopAnimating()
                    self.imageView.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }

}
