//
//  CoreDataStack.swift
//  DragonBall
//
//  Created by Victoria Aloy on 20/9/22.
//

import Foundation

import CoreData

protocol CoreDataServiceProtocol {
    var errorHandler: (Error) -> Void {get set}
    var persistentContainer: NSPersistentContainer {get}
    var viewContext: NSManagedObjectContext {get}
    var backgroundContext: NSManagedObjectContext {get}
    func performBackgroundTask(completion: @escaping (NSManagedObjectContext) -> Void)
    func performForegroundTask(completion: @escaping (NSManagedObjectContext) -> Void)
}

class CoreDataService: CoreDataServiceProtocol {
    
    static let shared = CoreDataService()
    var errorHandler: (Error) -> Void = {_ in }
    
    private init(){}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DragonBall")
        container.loadPersistentStores(completionHandler: { [weak self](storeDescription, error) in
            if let error = error {
                NSLog("CoreData error \(error), \(String(describing: error._userInfo))")
                self?.errorHandler(error)
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        let context:NSManagedObjectContext = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    func performForegroundTask(completion: @escaping (NSManagedObjectContext) -> Void) {
        self.viewContext.perform {
            completion(self.viewContext)
        }
    }
    
    func performBackgroundTask(completion: @escaping (NSManagedObjectContext) -> Void) {
        self.persistentContainer.performBackgroundTask(completion)
    }
}
