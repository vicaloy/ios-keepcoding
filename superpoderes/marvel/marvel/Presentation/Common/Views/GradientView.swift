//
//  GradientView.swift
//  marvel
//
//  Created by Victoria Aloy on 22/10/22.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    var colorArray: [UIColor] = [] {
        didSet {
            setNeedsLayout()
        }
    }
    var vertical: Bool = true {
        didSet {
            setNeedsLayout()
        }
    }
    
    static override var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let layer = layer as? CAGradientLayer else { return }
        layer.colors = colorArray.map({ $0.cgColor })
        layer.locations = [0.22, 0.22]
        /*if vertical {
            // top-down gradient
            layer.startPoint = CGPoint(x: 0.5, y: 0.0)
            layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        } else {
            // diagonal gradient
            layer.startPoint = CGPoint(x: 0.0, y: 0.0)
            layer.endPoint = CGPoint(x: 1.0, y: 1.0)
        }*/
    }

}

