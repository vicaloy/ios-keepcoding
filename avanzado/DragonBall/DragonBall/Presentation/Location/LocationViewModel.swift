//
//  LocationViewModel.swift
//  DragonBall
//
//  Created by Victoria Aloy on 23/9/22.
//

import Foundation
import MapKit

protocol LocationViewModelProtocol: AnyObject {
    func onViewsLoaded()
    func onViewWillAppeared()
}

class LocationViewModel{
    private let keyChain = KeyChainStore()
    private weak var viewDelegate: LocationViewProtocol?
    private let hero: Hero
    
    init(viewDelegate: LocationViewProtocol?, hero: Hero) {
        self.viewDelegate = viewDelegate
        self.hero = hero
    }
    
    private func onLocationsLoadedSuccessful(locations:[Location]?){
        if(locations?.isEmpty==false){
            executeUserInterfaceTask {
                self.viewDelegate?.onLocationLoad(locations: self.onLocationsForMap(locations: locations!))
            }
        }else{
            executeUserInterfaceTask {
                self.viewDelegate?.onShowAlert(title: "Empty locations", message: "The hero does not have locations", action: "Accept")
            }
        }
        
        
        
    }
    
    private func onLocationsLoadedFailure(){
        executeUserInterfaceTask {
            self.viewDelegate?.onShowAlert(title: "Try again", message: "Something was wrong", action: "Accept")
        }
    }
    
    private func onLocationsLoadCoreData(){
        let predicate = NSPredicate(format: "hero.id == '\(hero.id)'")
        let locationCoreDataRepo = LocationCoreDataRepository()
        locationCoreDataRepo.fetch(predicate: predicate){
            locations in
            if (locations?.isEmpty == false){
                self.onLocationsLoadedSuccessful(locations: locations)
            }else{
                self.onLocationsLoadService()
            }
        }
    }
    
    private func onSaveLocationsCoreData(locations: [Location]? ){
        if(locations?.isEmpty==false){
            let locationCoreDataRepo = LocationCoreDataRepository()
            locationCoreDataRepo.insert(locations: locations!)
        }
        
    }
    
    private func onLocationsLoadService(){
        let data = keyChain.read(service: keyChain.service, account: keyChain.loginTokenAccount)
        let token = String(decoding: data ?? Data(), as: UTF8.self)
        let locationService = LocationService(heroId: hero.id, token: token)
        locationService.execute(){ locations, error in
            switch (error as? ServiceError){
            case .none:
                self.onSaveLocationsCoreData(locations: locations)
                self.onLocationsLoadedSuccessful(locations: locations)
            case .some(.malformedURL), .some(.emptyResponse), .some(.statusCode), .some(.unknown), .some(.decodingFailed), .some(.requestParams):
                self.onLocationsLoadedFailure()
            }
        }
    }
    
    private func onLocationsForMap(locations: [Location]) -> [MKPointAnnotation]{
        return locations.map{
            locationToAnnotationMap(location: $0)
        }
    }
    
    private func locationToAnnotationMap(location: Location) ->MKPointAnnotation{
        let annotations = MKPointAnnotation()
        annotations.title = hero.name
        let lat = NumberFormatter().number(from: location.latitud ?? "0.0")?.doubleValue ?? 0.0
        let long = NumberFormatter().number(from: location.longitud ?? "0.0")?.doubleValue ?? 0.0
        annotations.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        return annotations
    }
    
}

extension LocationViewModel: LocationViewModelProtocol {
    func onViewWillAppeared() {
        
    }
    
    
    func onViewsLoaded() {
        self.onLocationsLoadCoreData()
    }
    
}
