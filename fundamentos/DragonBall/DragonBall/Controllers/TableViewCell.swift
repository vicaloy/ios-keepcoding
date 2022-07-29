//
//  HeroesTableViewCell.swift
//  DragonBall
//
//  Created by Victoria Aloy on 16/7/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static var cellIdentifier: String {
        String(describing: TableViewCell.self)
    }
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func prepareForReuse() {
        cellImage.image = nil
        cellName.text = nil
        cellDescription.text = nil
    }
    
    func setData(image: URL, name: String, description: String){
        cellName.text = name
        cellDescription.text = description
        cellImage.setImage(url: image)
    }
    
}
