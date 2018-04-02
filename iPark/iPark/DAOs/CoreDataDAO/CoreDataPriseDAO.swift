//
//  CoreDataPriseDAO.swift
//  iPark
//
//  Created by Johan BRUNET on 01/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

class CoreDataPriseDAO: PriseDAO {
    
    private let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Prise")
    
    func save() {
        CoreDataManager.save()
    }
    
    func insert(forMed medicament: Medicament, withDose dose: String, withQuant quantity: Int, withRappel rappel: Date) -> Prise {
        let dto = self.create()
        dto.medicament = medicament
        dto.dose = dose
        dto.quantite = Int16(quantity)
        dto.rappel = rappel as NSDate
        return dto
    }
    
    func create() -> Prise {
        return Prise(context: CoreDataManager.context)
    }
    
    func getByMedicament(for med: Medicament) -> [Prise]? {
        self.request.predicate = NSPredicate(format: "medicament == %@", med)
        do{
            let result = try CoreDataManager.context.fetch(self.request) as! [Prise]
            guard result.count != 0 else { return nil }
            return result
        }
        catch{
            return nil
        }
    }
    
    func getByDate(at date: Date) -> [Prise]? {
        self.request.predicate = NSPredicate(format: "rappel == %@", date as CVarArg)
        do{
            let result = try CoreDataManager.context.fetch(self.request) as! [Prise]
            guard result.count != 0 else { return nil }
            return result
        }
        catch{
            return nil
        }
    }
    
    func search(forMed medicament: Medicament, withDose dose: String, withQuant quantity: Int, withRappel rappel: Date) -> Prise? {
        self.request.predicate = NSPredicate(format: "medicament == %@ AND dose == %@ AND quantity == %@ AND rappel == %@", medicament, dose, quantity, rappel as CVarArg)
        do{
            let result = try CoreDataManager.context.fetch(self.request) as! [Prise]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    func getAll() -> [Prise]? {
        do{
            return try CoreDataManager.context.fetch(self.request) as? [Prise]
        }
        catch {
            return nil
        }
    }
    
    func delete(for prise: Prise) {
        CoreDataManager.context.delete(prise)
        self.save()
    }
    
    func add(_ prise: Prise) {
        if let _ = self.search(forMed: prise.med, withDose: prise.doseMed, withQuant: prise.quantiteMed, withRappel: prise.rappelPrise) {
            self.save()
        }
        else {
            let _ = self.insert(forMed: prise.med, withDose: prise.doseMed, withQuant: prise.quantiteMed, withRappel: prise.rappelPrise)
            self.save()
        }
    }

}

