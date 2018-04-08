//
//  TypeActiviteSet.swift
//  iPark
//
//  Created by Jade HENNEBERT on 28/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

class TypeActiviteSet {
    
    fileprivate var typActSet: [TypeActivite] = []
    let typeActiviteDAO: TypeActiviteDAO = CoreDataDAOFactory.getInstance().getTypeActiviteDAO()
    
    var count: Int {
        return self.typActSet.count
    }
    
    init(from typeActivites: [TypeActivite]?) {
        if let typActs = typeActivites {
            for t in typActs {
                self.typActSet.append(t)
            }
        }
    }
    
    @discardableResult
    func add(_ typeActivite: TypeActivite) -> TypeActiviteSet {
        if !self.contains(typeActivite) {
            self.typActSet.append(typeActivite)
            self.typeActiviteDAO.add(typeActivite)
        }
        return self
    }
    
    @discardableResult
    func remove(_ activite: TypeActivite) -> TypeActiviteSet {
        if self.contains(activite) {
            self.typActSet.remove(at: self.typActSet.index(of: activite)!)
            self.typeActiviteDAO.delete(for: activite)
        }
        return self
    }
    
    func get(_ i: Int) -> TypeActivite? {
        if(i < 0 || i >= typActSet.count){
            return nil
        }
        return self.typActSet[i]
    }
    
    func contains(_ typeActivite: TypeActivite) -> Bool {
        return self.typActSet.contains(where: {$0==typeActivite})
    }
    
    func sortByName() {
        return self.typActSet.sort(by: { (typ1, typ2) -> Bool in
            typ1.libelle! <= typ2.libelle!
        })
    }

}
