//
//  LocationCoreDataRepository.swift
//  DragonBall
//
//  Created by Victoria Aloy on 23/9/22.
//

import Foundation

class LocationCoreDataRepository {
    let worker: CoreDataWorker<LocationMO, Location>
    var location: Location?
   
    init(worker: CoreDataWorker<LocationMO, Location> = CoreDataWorker<LocationMO, Location>()){
        self.worker = worker
    }
    
    func fetch(predicate: NSPredicate? = nil, completion: @escaping ([Location]?) -> Void) {
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
    
    func delete(locations: [Location]){
        worker.delete(entities: locations){ (error) in
            guard let error = error else { return }
            print("\(error)")
        }
    }
}
