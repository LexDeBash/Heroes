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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator = showSpinner(in: imageView)
    }
    
    func configure(with superhero: Superhero) {
        mainLabel.text = superhero.name
        guard let url = URL(string: superhero.images.lg) else { return }
        NetworkManager.shared.fetchImageData(from: url) { result in
            switch result {
            case .success(let imageData):
                self.imageView.image = UIImage(data: imageData)
                self.activityIndicator?.stopAnimating()
            case .failure(let error):
                print(error)
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
