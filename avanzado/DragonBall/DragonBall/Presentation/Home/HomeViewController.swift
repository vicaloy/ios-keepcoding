//
//  HomeViewController.swift
//  DragonBall
//
//  Created by Victoria Aloy on 18/9/22.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func onCollectionLoad(heros: [Hero])
    func onShowAlert(title: String, message: String, action: String)
}

class HomeViewController: UIViewController {
    
    private let cellName = "HeroCollectionViewCell"
    private let cellReuseId = "cell"
    
    private var viewModel: HomeViewModelProtocol?
    
    private var heros: [Hero] = []
    private var filteredHeros: [Hero] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        bindCollectionView()
        viewModel?.onViewsLoaded()
    }
    
    func setViewModel(viewModel: HomeViewModel){
        self.viewModel = viewModel
    }
    
    
    private func bindCollectionView() {
        searchBar.delegate = self
        
        let nib = UINib(nibName: cellName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellReuseId)
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    private func load(loading:Bool){
        if(loading){
            activityIndicator.startAnimating()
        }else {
            activityIndicator.stopAnimating()
        }
    }
    
}

extension HomeViewController: HomeViewProtocol{
    func onCollectionLoad(heros: [Hero]) {
        self.heros = heros
        self.filteredHeros = heros
        self.collectionView.reloadData()
        self.load(loading: false)
    }
    
    func onShowAlert(title: String, message: String, action: String) {
        self.load(loading: false)
        showAlert(title: title, message: message, action: action)
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredHeros.count
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 6,
                      height: 150.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath)
        (cell as? HeroCollectionViewCell)?.setHero(hero: filteredHeros[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateDetail(context: self, hero: filteredHeros[indexPath.row])
    }
}

extension HomeViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredHeros = searchText.isEmpty ? heros : heros.filter { (item: Hero) -> Bool in
            return item.name?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
            
        collectionView.reloadData()
        }
}
