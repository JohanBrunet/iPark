//
//  File.swift
//  iPark
//
//  Created by Johan BRUNET on 19/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

protocol MedecinDAO {
    
    func save()
    func insert(lastName: String, adress: String, phone: String) -> Medecin
    func insert(lastName: String, adress: String, phone: String, specialty: Specialite) -> Medecin
    func create() -> Medecin
    func getByName(for lastName: String) -> [Medecin]?
    func getAll() -> [Medecin]?
    func delete(for medecin: Medecin)
    func search(forMedecin medecin: Medecin) -> Medecin?
    func search(forLastname lastname: String,  phone: String) -> Medecin?
    func add(_ medecin: Medecin)
}
