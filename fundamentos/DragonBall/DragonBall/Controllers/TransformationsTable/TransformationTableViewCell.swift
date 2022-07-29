//
//  TransformationTableViewCell.swift
//  DragonBall
//
//  Created by Victoria Aloy on 18/7/22.
//

import UIKit

class TransformationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var transformationName: UILabel!
    @IBOutlet weak var transformationDescription: UILabel!
    @IBOutlet weak var transformationImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTransformation(transformation: Transformation){
        transformationName.text = transformation.name
        transformationDescription.text = transformation.description
        transformationImage.setImage(url: transformation.photo)
    }
}
