//
//  ManagedObjectConvertible.swift
//  DragonBall
//
//  Created by Victoria Aloy on 20/9/22.
//

import CoreData

protocol ManagedObjectConvertible {
    associatedtype ManagedObject: NSManagedObject, ManagedObjectProtocol
    func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject?
    func toExistingManagedObject(in context: NSManagedObjectContext) -> ManagedObject?
    func deleteManagedObject(in context: NSManagedObjectContext)
}
