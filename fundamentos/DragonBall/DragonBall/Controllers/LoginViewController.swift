//
//  LoginViewController.swift
//  DragonBall
//
//  Created by Victoria Aloy on 16/7/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        activityIndicator.stopAnimating()
        
        if(UserDefaultsData.getToken() != nil){
            presentTabBar()
        }
        
    }
    
    
    @IBAction func onLoginTap(_ sender: Any) {
        
        let loginService = LoginService()
        let user = userTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        guard !user.isEmpty, !password.isEmpty else {
            showAlert(title: "Campos sin completar", message: "complete todos los campos para entrar")
            return
        }
        
        loginButton.isHidden = true
        activityIndicator.startAnimating()
        
        loginService.login(user: user, password: password) { [weak self] token, error in
            
            DispatchQueue.main.async {
                self?.loginButton.isHidden = false
                self?.activityIndicator.stopAnimating()
                
                if let error = error {
                    self?.showAlert(title: "Hubo un error", message: error.localizedDescription)
                    return
                }
                
                guard let token = token, !token.isEmpty else {
                    self?.showAlert(title: "No se encontro token")
                    return
                }
                UserDefaultsData.saveToken(token: token)
                self?.presentTabBar()
            }
        }
    }
    
    private func presentTabBar(){
        let tabBarViewController = UITabBarController()
        
        let heroesTableViewController = UINavigationController(rootViewController: HeroesTableViewController())
        let heroesCollectionViewController = UINavigationController(rootViewController: HeroesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        
        tabBarViewController.setViewControllers([heroesTableViewController, heroesCollectionViewController], animated: false)
        tabBarViewController.modalPresentationStyle = .fullScreen
        
        guard let items = tabBarViewController.tabBar.items else{
            return
        }
        items.first?.image = UIImage(systemName: "table")
        items.last?.image = UIImage(systemName: "square.grid.2x2")
        
        present(tabBarViewController, animated: true)
    }
    
}
