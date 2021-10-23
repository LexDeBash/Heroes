//
//  SuperHeroesViewController.swift
//  Heroes
//
//  Created by Alexey Efimov on 22.10.2021.
//

import UIKit

class SuperHeroesViewController: UICollectionViewController {
    
    private var superheroes: [Superhero] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSuperheroes()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        superheroes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "superhero", for: indexPath) as! CollectionViewCell
        let superhero = superheroes[indexPath.row]
        cell.configure(with: superhero)
        return cell
    }
    
    private func fetchSuperheroes() {
        NetworkManager.shared.fetchData { result in
            switch result {
            case .success(let superheroes):
                self.superheroes = superheroes
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
