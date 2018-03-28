//
//  CoreDataTypeActiviteDAO.swift
//  iPark
//
//  Created by Jade HENNEBERT on 28/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

class CoreDataTypeActiviteDAO: TypeActiviteDAO {
    
    private let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TypeActivite")
    
    func save(){
        CoreDataManager.save()
    }
    
    func insert(nomActivite: String) -> TypeActivite{
        let dto = self.create()
        dto.libelle = nomActivite
        return dto
    }
    
    func create() -> TypeActivite{
        return TypeActivite(context: CoreDataManager.context)
        
    }
    
    func getAll() -> [TypeActivite]?{
        do{
            return try CoreDataManager.context.fetch(self.request) as? [TypeActivite]
        }
        catch {
            return nil
        }
        
    }
    
    func delete(for activite: TypeActivite){
        CoreDataManager.context.delete(activite)
        
    }
    
    func add(_ activite: TypeActivite){
        let _ = self.insert( nomActivite: activite.libelle!)
        self.save()
    }
    
}
