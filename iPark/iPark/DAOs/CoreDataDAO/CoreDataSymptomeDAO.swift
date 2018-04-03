//
//  CoreDataSymptomeDAO.swift
//  iPark
//
//  Created by Kevin Giordani on 03/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

class CoreDataSymptomeDAO: SymptomeDAO {
    
    private let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Symptome")
    
    func save() {
        CoreDataManager.save()
    }
    
    func insert(etat: String, date: NSDate, evenements: [String]?) -> Symptome {
        let dto = self.create()
        dto.etat = etat
        dto.date = date
        dto.evenements = evenements as! NSObject
        return dto
    }
    
    func create() -> Symptome {
        return Symptome(context: CoreDataManager.context)
    }
    
    func getAll() -> [Symptome]? {
        do{
            return try CoreDataManager.context.fetch(self.request) as? [Symptome]
        }
        catch{
            return nil
        }
    }
    
    func delete(for symptome: Symptome) {
        CoreDataManager.context.delete(symptome)
    }
    
    func add(_ symptome: Symptome) {
        if let _ = self.search(date: symptome.date!) {
            self.save()
        }
    }
    
    func search(date: NSDate) -> Symptome? {
        self.request.predicate = NSPredicate(format: "date == %@ ", date)
        do{
            let result = try CoreDataManager.context.fetch(self.request) as! [Symptome]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    

}
