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
        Task {
            do {
                superheroes = try await NetworkManager.shared.fetchData()
                collectionView.reloadData()
            } catch {
                print(error)
            }
        }
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
}
