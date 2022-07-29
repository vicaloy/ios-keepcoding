//
//  HeroesCollectionViewController.swift
//  DragonBall
//
//  Created by Victoria Aloy on 17/7/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class HeroesCollectionViewController: UICollectionViewController {
    
    private var heros: [Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Heroes"
        
        collectionView?.register(UINib(nibName: "HeroeCollectionViewCell", bundle: nil),
                                 forCellWithReuseIdentifier: reuseIdentifier)
        
        let heroesService = HeroesService()
        
        heroesService.getHeroes { [weak self] heroes, _ in
            guard let self = self else { return }
            
            self.heros = heroes
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return heros.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        (cell as? HeroeCollectionViewCell)?.setHero(hero: heros[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let heroeDetailViewController = HeroeDetailViewController()
        heroeDetailViewController.hidesBottomBarWhenPushed = true
        heroeDetailViewController.setHero(hero: heros[indexPath.row])
        navigationController?.pushViewController(heroeDetailViewController, animated: true)
    }
    
}

extension HeroesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width / 2) - 6
        return CGSize(width: width, height: 140.0)
    }
}
