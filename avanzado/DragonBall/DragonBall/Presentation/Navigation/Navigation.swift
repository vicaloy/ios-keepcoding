//
//  Navigation.swift
//  DragonBall
//
//  Created by Victoria Aloy on 20/9/22.
//

import UIKit


func navigateHome(context: UIViewController){
    let tabBarViewController = UITabBarController()
    tabBarViewController.setViewControllers([createHomeViewController()], animated: false)
    tabBarViewController.modalPresentationStyle = .fullScreen
    
    guard let items = tabBarViewController.tabBar.items else{
        return
    }
    items.first?.image = UIImage(systemName: "square.grid.2x2")
    
    context.present(tabBarViewController, animated: true)
}

func navigateLogin(context: UIViewController){
   let loginViewController = createLoginViewController()
    let navigationController = UINavigationController(rootViewController: loginViewController)
    navigationController.modalPresentationStyle = .fullScreen
    context.present(navigationController, animated: true)
}

func navigateDetail(context: UIViewController, hero: Hero){
    let detailViewController = createDetailViewController(hero: hero)
    context.navigationController?.pushViewController(detailViewController, animated: true)
}
