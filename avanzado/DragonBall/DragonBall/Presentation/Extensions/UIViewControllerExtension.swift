//
//  UIViewControllerExtension.swift
//  DragonBall
//
//  Created by Victoria Aloy on 18/9/22.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, action: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: action, style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
