//
//  HeroeCollectionViewCell.swift
//  DragonBall
//
//  Created by Victoria Aloy on 17/7/22.
//

import UIKit

class HeroeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setHero(hero: Hero){
        heroName.text = hero.name
        heroImage.setImage(url: hero.photo)
    }
    
}
