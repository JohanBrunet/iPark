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

    private let request : NSFetchRequest<Medecin> = Medecin.fetchRequest()
    
    func save() {
        CoreDataManager.save()
    }
    
    func insert(lastName: String, firstName: String, adress: String, phone: String) -> Medecin {
        let dao = self.create()
        dao.nom_medecin = lastName
        dao.prenom_medecin = firstName
        dao.adresse = adress
        dao.telephone = phone
        return dao
    }
    
    func insert(lastName: String, firstName: String, adress: String, phone: String, specialty: Specialite) -> Medecin {
        let dao = self.create()
        dao.nom_medecin = lastName
        dao.prenom_medecin = firstName
        dao.adresse = adress
        dao.telephone = phone
        dao.specialite = specialty
        return dao
    }
    
    func create() -> Medecin {
        return Medecin(context: CoreDataManager.context)
    }
    
    func getByName(for lastName: String) -> [Medecin]? {
        self.request.predicate = NSPredicate(format: "firstname == %@", lastName)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Medecin]
            guard result.count != 0 else { return nil }
            return result
        }
        catch{
            return nil
        }
    }
    
    func search(forFirstname firstname: String, lastname: String,  phone: String) -> Medecin? {
        self.request.predicate = NSPredicate(format: "firstname == %@ AND lastname == %@ AND phone == %@", firstname, lastname, phone)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Medecin]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    func search(forMedecin medecin: Medecin) -> Medecin? {
        self.request.predicate = NSPredicate(format: "firstname == %@ AND lastname == %@ AND phone = %@", medecin.prenom_medecin!, medecin.nom_medecin!, medecin.telephone!)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Medecin]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    func getAll() -> [Medecin]? {
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        }
    }
    
    func delete(for medecin: Medecin) {
        CoreDataManager.context.delete(medecin)
    }
    
    func add(medecin: Medecin) {
        if let _ = self.search(forFirstname: medecin.prenom_medecin!, lastname: medecin.nom_medecin!, phone: medecin.telephone!) {
            self.save()
        }
        else {
            if let specialty = medecin.specialite {
                let _ = self.insert(lastName: medecin.nom_medecin!, firstName: medecin.prenom_medecin!, adress: medecin.adresse!, phone: medecin.telephone!, specialty: specialty)
            }
            else{
                let _ = self.insert(lastName: medecin.nom_medecin!, firstName: medecin.prenom_medecin!, adress: medecin.adresse!, phone: medecin.telephone!)
            }
            self.save()
        }
    }
    
}
