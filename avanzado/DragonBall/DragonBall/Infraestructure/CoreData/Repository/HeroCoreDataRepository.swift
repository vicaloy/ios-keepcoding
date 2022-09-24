//
//  HeroCoreDataRepository.swift
//  DragonBall
//
//  Created by Victoria Aloy on 20/9/22.
//

import Foundation

class HeroCoreDataRepository {
    let worker: CoreDataWorker<HeroMO, Hero>
   
    init(worker: CoreDataWorker<HeroMO, Hero> = CoreDataWorker<HeroMO, Hero>()){
        self.worker = worker
    }
    
    func fetch(completion: @escaping ([Hero]?) -> Void) {
        worker.get{(result: Result<[Hero], Error>) in
            switch result {
            case .success(let heros):
                completion(heros)
            case .failure(let error):
                print("\(error)")
                completion(nil)
            }
        }
    }
    
    func insert(heros: [Hero]){
        worker.upsert(entities: heros){ (error) in
            guard let error = error else { return }
            print("\(error)")
        }
    }
    
    func delete(heros: [Hero]){
        worker.delete(entities: heros){ (error) in
            guard let error = error else { return }
            print("\(error)")
        }
    }
}
