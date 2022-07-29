//
//  SplashViewController.swift
//  DragonBallApp
//
//  Created by Victoria Aloy on 28/7/22.
//

import UIKit

protocol SplashViewProtocol: AnyObject {
    func navigateToHome()
}

class SplashViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: SplashViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onViewsLoaded()
    }
    
    
}

extension SplashViewController: SplashViewProtocol {
    
    func navigateToHome() {
        let homeViewController = HomeViewController(collectionViewLayout: UICollectionViewFlowLayout())
        homeViewController.viewModel = HomeViewModel(viewDelegate: homeViewController)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}
