//
//  CoreDataSpecialitedto.swift
//  iPark
//
//  Created by Johan BRUNET on 27/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

class CoreDataSpecialiteDAO: SpecialiteDAO {
    
    private let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Specialite")
    
    func save() {
        CoreDataManager.save()
    }
    
    func insert(label: String) -> Specialite {
        let dto = self.create()
        dto.libelle = label
        return dto
    }
    func create() -> Specialite {
        return Specialite(context: CoreDataManager.context)
    }
    
    func getByName(for label: String) -> Specialite? {
        self.request.predicate = NSPredicate(format: "libelle == %@", label)
        do{
            let result = try CoreDataManager.context.fetch(self.request) as! [Specialite]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    func getAll() -> [Specialite]? {
        do{
            return try CoreDataManager.context.fetch(self.request) as? [Specialite]
        }
        catch{
            return nil
        }
    }
    
    func delete(for specialite: Specialite) {
        CoreDataManager.context.delete(specialite)
    }
    
    func add(_ specialite: Specialite) {
        if let _ = self.getByName(for: specialite.label) {
            self.save()
        }
        else {
            let _ = self.insert(label: specialite.label)
            self.save()
        }
    }
    
}
