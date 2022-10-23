//
//  NavigationView.swift
//  marvel
//
//  Created by Victoria Aloy on 22/10/22.
//

import SwiftUI

/*struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}*/

func setNavViewAppearance(){
    let coloredNavAppearance = UINavigationBarAppearance()
    coloredNavAppearance.configureWithOpaqueBackground()
    coloredNavAppearance.backgroundColor = MarvelColor.red
    coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: MarvelColor.red]
    coloredNavAppearance.shadowColor = .clear
    coloredNavAppearance.shadowImage = UIImage()
           
    UINavigationBar.appearance().compactAppearance = coloredNavAppearance
    UINavigationBar.appearance().standardAppearance = coloredNavAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
}

func setNavTitleAppearance(){
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = MarvelColor.red
    
    let attrs: [NSAttributedString.Key: Any] = [
        .foregroundColor: MarvelColor.white,
        .font: UIFont(name: "Marvel-Regular", size: 120) ?? UIFont.monospacedSystemFont(ofSize: 120, weight: .black)
    ]

    appearance.largeTitleTextAttributes = attrs

    UINavigationBar.appearance().scrollEdgeAppearance = appearance
}

func removeNav(){
    /*let navigationBarAppearance = UINavigationBarAppearance()
    navigationBarAppearance.shadowColor = .clear
    UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance*/
    
    let appearance = UINavigationBarAppearance()
        appearance.shadowImage = nil
        appearance.shadowColor = nil
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().compactAppearance = appearance
}

func setNavViewBackground(){
    let view = GradientView()
    view.colorArray = [MarvelColor.red, MarvelColor.red, MarvelColor.black]
    UICollectionView.appearance().backgroundView = view
}
