//
//  LocationViewController.swift
//  DragonBall
//
//  Created by Victoria Aloy on 23/9/22.
//

import UIKit
import MapKit

protocol LocationViewProtocol: AnyObject {
    func onLocationLoad(locations: [MKPointAnnotation])
    func onShowAlert(title: String, message: String, action: String)
}


class LocationViewController: UIViewController {

    @IBOutlet weak var locationView: MKMapView!
    
    private var viewModel: LocationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onViewsLoaded()
        
    }

    
    func setViewModel(viewModel: LocationViewModel){
        self.viewModel = viewModel
    }

}

extension LocationViewController: LocationViewProtocol {
    func onLocationLoad(locations: [MKPointAnnotation]) {
        locationView.addAnnotations(locations)
    }
    
    func onShowAlert(title: String, message: String, action: String) {
        showAlert(title: title, message: message, action: action)
    }
    
    
}
