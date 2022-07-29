//
//  TransformationsTableViewController.swift
//  DragonBall
//
//  Created by Victoria Aloy on 18/7/22.
//

import UIKit

class TransformationsTableViewController: UITableViewController {
    
    private var transformations: [Transformation] = []
    private var heroId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Transformaciones"
        
        tableView?.register(UINib(nibName: TableViewCell.cellIdentifier, bundle: nil),
                            forCellReuseIdentifier: TableViewCell.cellIdentifier)
        
        let transformationsService = TransformationsService()
        
        transformationsService.getTransformations(id: heroId) { [weak self] transformations, _ in
            guard let self = self else { return }
            
            self.transformations = transformations
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transformations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifier, for: indexPath) as? TableViewCell else{
            return UITableViewCell()
        }
        
        cell.setData(image: transformations[indexPath.row].photo, name: transformations[indexPath.row].name, description: transformations[indexPath.row].description)
        
        return cell
    }
    
    func setHeroId(id: String){
        self.heroId = id
    }
    
}
