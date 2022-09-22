//
//  DetailViewController.swift
//  DragonBall
//
//  Created by Victoria Aloy on 18/9/22.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func onBindHero(hero: Hero)
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var descip: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!

    private var viewModel: DetailViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onViewsLoaded()
    }
    
    func setViewModel(viewModel: DetailViewModel){
        self.viewModel = viewModel
    }

    private func bindHero(hero: Hero){
        descip.text = hero.description
        image.setImage(url: hero.photo)
        name.text = hero.name
    }
}

extension DetailViewController: DetailViewProtocol {
    func onBindHero(hero: Hero) {
        self.bindHero(hero: hero)
    }
    
    
}
