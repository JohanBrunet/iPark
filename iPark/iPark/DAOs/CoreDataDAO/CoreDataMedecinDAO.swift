//
//  CoreDataMedecinDAO.swift
//  iPark
//
//  Created by Johan BRUNET on 23/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

class CoreDataMedecinDAO: MedecinDAO {

    private let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Medecin")
    
    func save() {
        CoreDataManager.save()
    }
    
    func insert(lastName: String, adress: String, phone: String) -> Medecin {
        let dao = self.create()
        dao.nom_medecin = lastName
        dao.adresse = adress
        dao.telephone = phone
        return dao
    }
    
    func insert(lastName: String, adress: String, phone: String, specialty: Specialite) -> Medecin {
        let dao = self.create()
        dao.nom_medecin = lastName
        dao.adresse = adress
        dao.telephone = phone
        dao.specialite = specialty
        return dao
    }
    
    func create() -> Medecin {
        return Medecin(context: CoreDataManager.context)
    }
    
    func getByName(for lastName: String) -> [Medecin]? {
        self.request.predicate = NSPredicate(format: "nom_medecin == %@", lastName)
        do{
            let result = try CoreDataManager.context.fetch(self.request) as! [Medecin]
            guard result.count != 0 else { return nil }
            return result
        }
        catch{
            return nil
        }
    }
    
    func search(forLastname lastname: String,  phone: String) -> Medecin? {
        self.request.predicate = NSPredicate(format: "nom_medecin == %@ AND telephone == %@", lastname, phone)
        do{
            let result = try CoreDataManager.context.fetch(self.request) as! [Medecin]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    func search(forMedecin medecin: Medecin) -> Medecin? {
        return self.search(forLastname: medecin.nom, phone: medecin.tel)
    }
    
    func getAll() -> [Medecin]? {
        do{
            return try CoreDataManager.context.fetch(self.request) as? [Medecin]
        }
        catch{
            return nil
        }
    }
    
    func delete(for medecin: Medecin) {
        CoreDataManager.context.delete(medecin)
    }
    
    func add(_ medecin: Medecin) {
        if let _ = self.search(forLastname: medecin.nom_medecin!, phone: medecin.telephone!) {
            self.save()
        }
        else {
            if let specialty = medecin.specialite {
                let _ = self.insert(lastName: medecin.nom, adress: medecin.adr, phone: medecin.tel, specialty: specialty)
            }
            else{
                let _ = self.insert(lastName: medecin.nom, adress: medecin.adr, phone: medecin.tel)
            }
            self.save()
        }
    }
    
}
