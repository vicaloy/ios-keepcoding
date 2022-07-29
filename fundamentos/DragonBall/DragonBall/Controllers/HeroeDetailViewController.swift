//
//  HeroeDetailViewController.swift
//  DragonBall
//
//  Created by Victoria Aloy on 17/7/22.
//

import UIKit

struct Heroe{
    var name: String
}

class HeroeDetailViewController: UIViewController {
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UITextView!
    
    private var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let hero = hero else {
            return
        }
        
        self.title = hero.name
        heroName.text = hero.name
        heroDescription.text = hero.description
        heroImage.setImage(url: hero.photo)
    }
    
    @IBAction func onTransformationsTap(_ sender: Any) {
        
        let transformationTableViewController = TransformationsTableViewController()
        transformationTableViewController.setHeroId(id: hero?.id ?? "")
        transformationTableViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(transformationTableViewController, animated: true)
    }
    
    func setHero(hero: Hero){
        self.hero = hero
    }
}
