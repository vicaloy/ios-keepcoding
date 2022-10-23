//
//  ImageDownloader.swift
//  marvel
//
//  Created by Victoria Aloy on 23/10/22.
//

import Foundation
import Combine
import SwiftUI

class ImageDownloader: ObservableObject{
    @Published
    var photo : UIImage?
    
    var subscriber: AnyCancellable?
    
    func downloadImage(urlS:String) -> Void{
        let url = URL(string: urlS)!
        
        subscriber = URLSession.shared
            .dataTaskPublisher(for: url)
            .map{
                UIImage(data: $0.data)
            }
            .replaceError(with: UIImage(named: "Marvel"))
            .receive(on: DispatchQueue.main)
            .sink{
                if let fotoDown = $0{
                    self.photo = fotoDown
                }
            }
    }

}
