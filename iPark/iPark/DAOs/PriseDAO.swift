//
//  PriseDAO.swift
//  iPark
//
//  Created by Johan BRUNET on 01/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

protocol PriseDAO {
    
    func save()
    func insert(forMed medicament: Medicament, withDose dose: String, withQuant quantity: Int, withRappel rappel: Date) -> Prise
    func create() -> Prise
    func getByMedicament(for med: Medicament) -> [Prise]?
    func getByDate(at date: Date) -> [Prise]?
    func search(forMed medicament: Medicament, withDose dose: String, withQuant quantity: Int, withRappel rappel: Date) -> Prise?
    func getAll() -> [Prise]?
    func delete(for prise: Prise)
    func add(_ prise: Prise)
    func realiserPrise(_ prise: Prise)
    
}
