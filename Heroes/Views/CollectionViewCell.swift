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
        Task {
            if url == imageURL {
                let imageData = try await NetworkManager.shared.fetchImageData(from: url)
                imageView.image = UIImage(data: imageData)
                activityIndicator?.stopAnimating()
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
