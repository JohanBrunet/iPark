//
//  SpecialiteDAO.swift
//  iPark
//
//  Created by Johan BRUNET on 27/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

protocol SpecialiteDAO {
    
    func save()
    func insert(label: String) -> Specialite
    func create() -> Specialite
    func getByName(for label: String) -> Specialite?
    func getAll() -> [Specialite]?
    func delete(for specialite: Specialite)
    func add(_ specialite: Specialite)
    
}
