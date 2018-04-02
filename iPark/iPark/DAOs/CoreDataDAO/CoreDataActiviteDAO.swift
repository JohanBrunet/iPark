//
//  CoreDataActivityDAO.swift
//  iPark
//
//  Created by Jade Hennebert on 24/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

class CoreDataActiviteDAO: ActiviteDAO {    
    
     private let request : NSFetchRequest<Activite> = Activite.fetchRequest()
    
    
    func save() {
        CoreDataManager.save()
    }
    
    func insert(nomActivite: String, duree: Int32, date: NSDate, remarque: String?) -> Activite {
        let dao = self.create()
        dao.libelle = nomActivite
        dao.duree = duree
        dao.date = date
        dao.remarque = remarque
        return dao
    }
    
    func insert(typeActivite: TypeActivite, duree: Int32, date: NSDate, remarque: String?) -> Activite {
        let dao = self.create()
        dao.type = typeActivite
        dao.duree = duree
        dao.date = date
        dao.remarque = remarque
        return dao
    }
    
    func create() -> Activite {
        return Activite(context: CoreDataManager.context)
    }
    
    func getByName(for nomActivite: String) -> [Activite]? {
        self.request.predicate = NSPredicate(format: "libelle == %@", nomActivite)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Activite]
            guard result.count != 0 else { return nil }
            return result
        }
        catch{
            return nil
        }
    }
    
    func getByType(for typeActivite: TypeActivite) -> [Activite]? {
        self.request.predicate = NSPredicate(format: "type == %@", typeActivite)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Activite]
            guard result.count != 0 else { return nil }
            return result
        }
        catch{
            return nil
        }
    }
    
    func getAll() -> [Activite]? {
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        }
    }
    
    
    func delete(for Activite: Activite) {
        CoreDataManager.context.delete(Activite)
    }
    
   
    
    func add(activite: Activite) {
        if let _ = self.search(date: activite.dateActivite) {
            self.save()
        }
        else {
            if activite.nomActivite != nil{
                let _ = self.insert(nomActivite: activite.nomActivite!, duree: activite.dureeActivite, date: activite.dateActivite, remarque: activite.remarqueActivite)
            }
            else{
                let _ = self.insert(typeActivite: activite.typeActivite!, duree: activite.dureeActivite, date: activite.dateActivite, remarque: activite.remarqueActivite)
            }
            self.save()
        }
    }
    
    func search(date: NSDate) -> Activite? {
        self.request.predicate = NSPredicate(format: "date == %@ ", date)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Activite]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    }
    

