//
//  LocationCoreDataRepository.swift
//  DragonBall
//
//  Created by Victoria Aloy on 23/9/22.
//

import Foundation

class LocationCoreDataRepository {
    let worker: CoreDataWorker<LocationEntity, Location>
   
    init(worker: CoreDataWorker<LocationEntity, Location> = CoreDataWorker<LocationEntity, Location>()){
        self.worker = worker
    }
    
    func fetch(predicate: NSPredicate, completion: @escaping ([Location]?) -> Void) {
        worker.get(with: predicate){
            (result: Result<[Location], Error>) in
            
            switch result {
            case .success(let locations):
                completion(locations)
            case .failure(let error):
                print("\(error)")
                completion(nil)
            }
        }
    }
    
    func insert(locations: [Location]){
        worker.upsert(entities: locations){ (error) in
            guard let error = error else { return }
            print("\(error)")
        }
    }
}
