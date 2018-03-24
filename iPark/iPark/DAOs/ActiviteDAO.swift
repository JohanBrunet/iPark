//
//  ActiviteDAO.swift
//  iPark
//
//  Created by Jade Hennebert on 24/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

protocol ActiviteDAO {
    
    func save()
    func insert(nomActivite: String, duree: Int32, date : NSDate, remarque: String?) -> Activite
    func insert(typeActivite : TypeActivite, duree: Int32, date : NSDate, remarque: String?) -> Activite
    func create() -> Activite
    func getByName(for nomActivite: String) -> [Activite]?
    func getByType(for typeActivite: TypeActivite) -> [Activite]?
    func getAll() -> [Activite]?
    func delete(for Activite: Activite)
    func search( nomActivite: String, date: NSDate,  duree: Int32) -> Activite?
    func search( typeActivite: TypeActivite, date: NSDate,  duree: Int32) -> Activite?
    func add(activite: Activite)
}
