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
    class func save() throws {
        do {
            try CoreDataManager.context.save()
        } catch let error as NSError {
            throw error
        }
    }
}
