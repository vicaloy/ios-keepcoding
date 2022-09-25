//
//  CoreDataWorker.swift
//  DragonBall
//
//  Created by Victoria Aloy on 20/9/22.
//

import Foundation
import CoreData

enum CoreDataWorkerError: Error{
    case cannotFetch(String)
    case cannotSave(Error)
    case cannotDelete(String)
}

class CoreDataWorker<ManagedEntity, Entity> where
    ManagedEntity: NSManagedObject,
    ManagedEntity: ManagedObjectProtocol,
Entity: ManagedObjectConvertible {
    
    let coreData: CoreDataServiceProtocol
    
    init(coreData: CoreDataServiceProtocol = CoreDataService.shared) {
        self.coreData = coreData
    }
    
    func get(with predicate: NSPredicate?=nil, sortDescriptors: [NSSortDescriptor]?=nil, fetchLimit: Int?=nil,
             completion: @escaping (Result<[Entity], Error>) -> Void) {
        
        coreData.performForegroundTask{ (context) in
            do {
                let fetchRequest = ManagedEntity.fetchRequest()
                fetchRequest.predicate = predicate
                fetchRequest.sortDescriptors = sortDescriptors
                if let fetchLimit = fetchLimit {
                    fetchRequest.fetchLimit = fetchLimit
                }
                let results = try context.fetch(fetchRequest) as? [ManagedEntity]
                let items: [Entity] = results?.compactMap { $0.toEntity() as? Entity } ?? []
                completion(.success(items))
            } catch {
                let fetchError = CoreDataWorkerError.cannotFetch("Cannot fetch error: \(error))")
                completion(.failure(fetchError))
            }
        }
    }
    
    func upsert(entities: [Entity], completion: @escaping (Error?) -> Void) {
        coreData.performBackgroundTask { (context) in
            _ = entities.compactMap({ (entity) -> ManagedEntity? in
                return entity.toManagedObject(in: context) as? ManagedEntity
            })
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(CoreDataWorkerError.cannotSave(error))
            }
        }
    }
    
    func delete(entities: [Entity], completion: @escaping (Error?) -> Void) {
        coreData.performBackgroundTask { (context) in
            do {
                entities.forEach{
                    guard let mo = $0.toExistingManagedObject(in: context)
                    else{
                        completion(CoreDataWorkerError.cannotDelete("Not existing managed object"))
                        return
                    }
                    context.delete(mo)
                }
                try context.save()
                completion(nil)
            } catch {
                completion(CoreDataWorkerError.cannotDelete("Cannot delete"))
            }
        }
    }
    
}
