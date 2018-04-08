//
//  CoreDataRendezVousDAO.swift
//  iPark
//
//  Created by Johan BRUNET on 27/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

class CoreDataRendezVousDAO: RendezVousDAO {
    
    private let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RendezVous")
    
    func save() {
        CoreDataManager.save()
    }
    
    func insert(for date: Date, with medecin: Medecin) -> RendezVous {
        let dto = self.create()
        dto.date = date as NSDate
        dto.medecin = medecin
        return dto
    }
    
    func insert(for date: Date, rappel: Date, with medecin: Medecin) -> RendezVous {
        let dto = self.create()
        dto.date = date as NSDate
        dto.rappel = rappel as NSDate
        dto.medecin = medecin
        return dto
    }
    
    func getByMedecin(for medecin: Medecin) -> [RendezVous]? {
        self.request.predicate = NSPredicate(format: "medecin == %@", medecin)
        do{
            let result = try CoreDataManager.context.fetch(self.request) as! [RendezVous]
            guard result.count != 0 else { return nil }
            return result
        }
        catch{
            return nil
        }
    }
    
    func search(forDate date: Date, with medecin: Medecin) -> RendezVous? {
        self.request.predicate = NSPredicate(format: "date == %@ AND medecin == %@", date as CVarArg, medecin)
        do{
            let result = try CoreDataManager.context.fetch(self.request) as! [RendezVous]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    func create() -> RendezVous {
        return RendezVous(context: CoreDataManager.context)
    }

    func getAll() -> [RendezVous]? {
        do{
            return try CoreDataManager.context.fetch(self.request) as? [RendezVous]
        }
        catch{
            return nil
        }
    }
    
    func delete(for rdv: RendezVous) {
        CoreDataManager.context.delete(rdv)
        self.save()
    }
    
    func add(_ rdv: RendezVous) {
        if let _ = self.search(forDate: rdv.dateRDV, with: rdv.med!) {
            self.save()
        }
        else {
            if rdv.rappelRDV != nil {
                let _ = self.insert(for: rdv.dateRDV, with: rdv.med!)
            }
            else {
                let _ = self.insert(for: rdv.dateRDV, rappel: rdv.rappelRDV!, with: rdv.med!)
            }
            self.save()
        }
    }
    
}
