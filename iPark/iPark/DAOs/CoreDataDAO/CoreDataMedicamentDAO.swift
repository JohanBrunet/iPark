//
//  CoreDataMedicamentDAO.swift
//  iPark
//
//  Created by Johan BRUNET on 01/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

class CoreDataMedicamentDAO: MedicamentDAO {
    
    private let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Medicament")
    
    func save() {
        CoreDataManager.save()
    }
    
    func insert(forName name: String, withDoses doses: [String]) -> Medicament {
        let dto = self.create()
        dto.nom_medicament = name
        dto.doses_medicament = doses as NSObject
        return dto
    }
    
    func create() -> Medicament {
        return Medicament(context: CoreDataManager.context)
    }
    
    func getByName(for name: String) -> Medicament? {
        self.request.predicate = NSPredicate(format: "nom_medicament == %@", name)
        do{
            let result = try CoreDataManager.context.fetch(self.request) as! [Medicament]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    func getAll() -> [Medicament]? {
        do{
            return try CoreDataManager.context.fetch(self.request) as? [Medicament]
        }
        catch {
            return nil
        }
    }
    
    func delete(for med: Medicament) {
        CoreDataManager.context.delete(med)
        self.save()
    }
    
    func add(_ med: Medicament) {
        if let _ = self.getByName(for: med.nom) {
            self.save()
        }
        else {
            let _ = self.insert(forName: med.nom, withDoses: med.doses)
            self.save()
        }
    }
    
}
