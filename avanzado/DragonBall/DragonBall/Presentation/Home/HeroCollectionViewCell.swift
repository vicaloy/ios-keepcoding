//
//  HeroCollectionViewCell.swift
//  DragonBall
//
//  Created by Victoria Aloy on 18/9/22.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imgActivityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        image.image = nil
        name.text = nil
    }
    
    func setHero(hero: Hero){
        name.text = hero.name
        image.setImage(url: hero.photo){
            self.imgActivityIndicator.stopAnimating()
        }
    }

}
