//
//  UIImageViewExtension.swift
//  DragonBall
//
//  Created by Victoria Aloy on 17/9/22.
//

import UIKit

typealias ImageCompletion = (UIImage?) -> Void
extension UIImageView {
    
    func setImage(url: URL?, completion: @escaping () -> Void) {
        if(url != nil){
            downloadImageWithUrlSession(url: url!) { [weak self] image in
                DispatchQueue.main.async {
                    completion()
                    self?.image = image
                }
            }
        }else{
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    private func downloadImageWithUrlSession(url: URL, completion: ImageCompletion?) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let image = UIImage(data: data)
            else {
                completion?(nil)
                return
            }
            completion?(image)
        }.resume()
    }
    
}
