//
//  ActiviteSet.swift
//  iPark
//
//  Created by Jade Hennebert on 27/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

class ActiviteSet {
    
    fileprivate var actSet: [Activite] = []
    let activiteDAO: ActiviteDAO = CoreDataDAOFactory.getInstance().getActiviteDAO()
    
    var count: Int {
        return self.actSet.count
    }
    
    init(from activites: [Activite]?) {
        if let acts = activites {
            for a in acts {
                self.actSet.append(a)
            }
        }
    }
    
    @discardableResult
    func add(_ activite: Activite) -> ActiviteSet {
        if !self.contains(activite) {
            self.actSet.append(activite)
            self.activiteDAO.add(activite: activite)
        }
        return self
    }
    
    @discardableResult
    func remove(_ activite: Activite) -> ActiviteSet {
        if self.contains(activite) {
            self.actSet.remove(at: self.actSet.index(of: activite)!)
            self.activiteDAO.delete(for: activite)
        }
        return self
    }
    
    func get(_ i: Int) -> Activite? {
        if(i < 0 || i >= actSet.count){
            return nil
        }
        return self.actSet[i]
    }
    
    func contains(_ activite: Activite) -> Bool {
        return self.actSet.contains(where: {$0==activite})
    }
    
    //    func sort() -> MedecinSet {
    //
    //    }
    
}
