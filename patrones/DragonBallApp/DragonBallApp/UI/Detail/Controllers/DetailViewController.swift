//
//  DetailViewController.swift
//  DragonBallApp
//
//  Created by Victoria Aloy on 29/7/22.
//

import UIKit

protocol DetailViewProtocol {
    func update(hero: Hero)
    func update(villain: Villain)
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var scoreOrEvil: UILabel!
    @IBOutlet weak var desc: UITextView!
    
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.onViewsLoaded()
    }
    
    private func update(character: DBCharacter){
        image.setImage(url: character.photo)
        name.text = character.name
        id.text = character.id
        desc.text = character.description
    }
    
}

extension DetailViewController: DetailViewProtocol {
    func update(hero: Hero) {
        update(character: hero)
        scoreOrEvil.text = String(describing: hero.score)
    }
    
    func update(villain: Villain) {
        update(character: villain)
        scoreOrEvil.text = String(describing: villain.evil)
    }
}
