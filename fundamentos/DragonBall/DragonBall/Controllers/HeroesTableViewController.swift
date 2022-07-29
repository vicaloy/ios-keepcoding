//
//  HeroesTableViewController.swift
//  DragonBall
//
//  Created by Victoria Aloy on 16/7/22.
//

import UIKit

class HeroesTableViewController: UITableViewController {
    
    private var heros: [Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Heroes"
        
        tableView?.register(UINib(nibName: TableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: TableViewCell.cellIdentifier)
        
        let heroesService = HeroesService()
        
        heroesService.getHeroes { [weak self] heroes, _ in
            guard let self = self else { return }
            
            self.heros = heroes
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return heros.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifier, for: indexPath) as? TableViewCell else{
            return UITableViewCell()
        }
        
        cell.setData(image: heros[indexPath.row].photo, name: heros[indexPath.row].name, description: heros[indexPath.row].description)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let heroeDetailViewController = HeroeDetailViewController()
        heroeDetailViewController.hidesBottomBarWhenPushed = true
        heroeDetailViewController.setHero(hero: heros[indexPath.row])
        navigationController?.pushViewController(heroeDetailViewController, animated: true)
        
    }
    
}
