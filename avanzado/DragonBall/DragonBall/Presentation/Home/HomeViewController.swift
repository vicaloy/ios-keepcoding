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
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onViewsLoaded()
    }
    
    func setViewModel(viewModel: HomeViewModel){
        self.viewModel = viewModel
    }
    
    
    private func bindCollectionView() {
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
        self.bindCollectionView()
        self.load(loading: false)
    }
    
    func onShowAlert(title: String, message: String, action: String) {
        showAlert(title: title, message: message, action: action)
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heros.count
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 6,
                      height: 150.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath)
        (cell as? HeroCollectionViewCell)?.setHero(hero: heros[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateDetail(context: self, hero: heros[indexPath.row])
    }
}
