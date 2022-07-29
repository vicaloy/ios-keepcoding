//
//  HomeViewController.swift
//  DragonBallApp
//
//  Created by Victoria Aloy on 28/7/22.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    
    func navigateToDetail(character: DBCharacter)
    
    func updateDBCharacters()
}

class HomeViewController: UICollectionViewController {
    let cell = "CharacterViewCell"
    var viewModel: HomeViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.onViewsLoaded()
        
        collectionView?.register(UINib(nibName: cell, bundle: nil), forCellWithReuseIdentifier: cell)
        
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel?.dataCount ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath) as? CharacterViewCellController else{
            return UICollectionViewCell()
        }
        
        guard let character = viewModel?.getCharacter(for: indexPath.row) else{
            return UICollectionViewCell()
        }
        
        cell.setCharacter(character: character)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel?.onSelectedItem(at: indexPath.row)
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width / 2) - 6,
               height: 185.0)
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func updateDBCharacters() {
        collectionView.reloadData()
        
    }
    
    func navigateToDetail(character: DBCharacter) {
        let detailViewController = DetailViewController()
        detailViewController.viewModel = DetailViewModel(viewDelegate: detailViewController, character: character)
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
