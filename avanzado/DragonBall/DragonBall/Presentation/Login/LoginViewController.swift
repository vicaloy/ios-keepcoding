//
//  LoginViewController.swift
//  DragonBall
//
//  Created by Victoria Aloy on 17/9/22.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func onLoading(loading: Bool)
    func onShowAlert(title: String, message: String, action: String)
    func onNavigateHome()
}

class LoginViewController: UIViewController {
    
    private var viewModel: LoginViewModelProtocol?
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func onLoginButtonTap(_ sender: Any) {
        viewModel?.onLoginButtonTap(user: userTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    func setViewModel(viewModel: LoginViewModelProtocol){
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    private func load(loading:Bool){
        if(loading){
            activityIndicator.startAnimating()
        }else {
            activityIndicator.stopAnimating()
        }
        loginButton.isHidden = loading
    }
    
}

extension LoginViewController: LoginViewProtocol {
    func onShowAlert(title: String, message: String, action: String){
        showAlert(title: title, message: message, action: action)
    }
    
    func onNavigateHome(){
        navigateHome(context: self)
    }
    
    func onLoading(loading: Bool) {
        load(loading: loading)
    }
}

