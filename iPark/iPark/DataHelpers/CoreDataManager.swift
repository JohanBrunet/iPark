//
//  CoreDataManager.swift
//  iPark
//
//  Created by Johan BRUNET on 12/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import CoreData
import UIKit

class CoreDataManager : NSObject{
    static var context : NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Application failed")
        }
        return appDelegate.persistentContainer.viewContext
    }
    static func entity(forName name: String) -> NSEntityDescription{
        guard let entity = NSEntityDescription.entity(forEntityName: name, in: self.context) else {
            fatalError("Entity failed")
        }
        return entity
    }
    static func save() -> NSError? {
        do {
            try CoreDataManager.context.save()
            return nil
        } catch let error as NSError {
            return error
        }
    }
}
