//
//  Di.swift
//  DragonBall
//
//  Created by Victoria Aloy on 20/9/22.
//

import UIKit

func createHomeViewController()->UINavigationController{
    let homeViewController = HomeViewController()
    let homeViewModel = HomeViewModel(viewDelegate: homeViewController)
    homeViewController.setViewModel(viewModel: homeViewModel)
    return UINavigationController(rootViewController: homeViewController)
}

func createLoginViewController()->UIViewController{
    let loginViewController = LoginViewController()
    let loginViewModel = LoginViewModel(viewDelegate: loginViewController)
    loginViewController.setViewModel(viewModel: loginViewModel)
    return loginViewController
}

func createLaunchViewController()->UIViewController{
    let launchViewController = LaunchViewController()
    let launchViewModel = LaunchViewModel(viewDelegate: launchViewController)
    launchViewController.setViewModel(viewModel: launchViewModel)
    return launchViewController
}

func createDetailViewController(hero: Hero)->UIViewController{
    let detailViewController = DetailViewController()
    let detailViewModel = DetailViewModel(viewDelegate: detailViewController, hero: hero)
    detailViewController.setViewModel(viewModel: detailViewModel)
    return detailViewController
}

func createLocationViewController(hero: Hero)->UIViewController{
    let locationViewController = LocationViewController()
    let locationViewModel = LocationViewModel(viewDelegate: locationViewController, hero: hero)
    locationViewController.setViewModel(viewModel: locationViewModel)
    return locationViewController
}

