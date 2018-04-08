//
//  TypeActiviteDAO.swift
//  iPark
//
//  Created by Jade HENNEBERT on 28/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

protocol TypeActiviteDAO {
    
    func save()
    func insert(nomActivite: String) -> TypeActivite
    func create() -> TypeActivite
    func getAll() -> [TypeActivite]?
    func delete(for activite: TypeActivite)
    func add(_ activite: TypeActivite)
    func search( name : String ) -> TypeActivite?

}
