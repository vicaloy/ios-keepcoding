//
//  CharacterViewCellController.swift
//  DragonBallApp
//
//  Created by Victoria Aloy on 28/7/22.
//

import UIKit

class CharacterViewCellController: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        name.text = nil
        image.image = nil
    }
    
    func setCharacter(character: DBCharacter){
        name.text = character.name
        image.setImage(url: character.photo)
    }
}
