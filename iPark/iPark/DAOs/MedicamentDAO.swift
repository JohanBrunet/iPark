//
//  MedicamentDAO.swift
//  iPark
//
//  Created by Johan BRUNET on 01/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

protocol MedicamentDAO {
    
    func save()
    func insert(forName name: String, withDoses doses: [String]) -> Medicament
    func create() -> Medicament
    func getByName(for name: String) -> Medicament?
    func getAll() -> [Medicament]?
    func delete(for med: Medicament)
    func add(_ med: Medicament)
    
}
