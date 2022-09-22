//
//  LaunchViewController.swift
//  DragonBall
//
//  Created by Victoria Aloy on 20/9/22.
//

import UIKit

protocol LaunchViewProtocol: AnyObject {
    func onNavigateLogin()
    func onNavigateHome()
}

class LaunchViewController: UIViewController {
    
    private var viewModel: LaunchViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onViewsLoaded()
    }
    
    func setViewModel(viewModel: LaunchViewModelProtocol){
        self.viewModel = viewModel
    }
}

extension LaunchViewController: LaunchViewProtocol {
    
    func onNavigateHome(){
        navigateHome(context: self)
    }
    
    func onNavigateLogin() {
        navigateLogin(context: self)
    }
}
