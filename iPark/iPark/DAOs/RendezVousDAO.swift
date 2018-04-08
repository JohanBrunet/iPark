//
//  RendezVousDAO.swift
//  iPark
//
//  Created by Johan BRUNET on 27/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

protocol RendezVousDAO {
    
    func save()
    func insert(for date: Date, with medecin: Medecin) -> RendezVous
    func create() -> RendezVous
    func getByMedecin(for medecin: Medecin) -> [RendezVous]?
    func getAll() -> [RendezVous]?
    func delete(for rdv: RendezVous)
    func search(forDate date: Date,  with medecin: Medecin) -> RendezVous?
    func add(_ rdv: RendezVous)
    
}
