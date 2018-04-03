//
//  SymptomeDAO.swift
//  iPark
//
//  Created by Kevin Giordani on 03/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

protocol SymptomeDAO{
    
    func save()
    func insert(etat: String, date : NSDate, evenements : [String]? ) -> Symptome
    func create() -> Symptome
    func getAll() -> [Symptome]?
    func delete(for symptome: Symptome)
    func add(_ symptome: Symptome)
    func search( date : NSDate ) -> Symptome?
}
