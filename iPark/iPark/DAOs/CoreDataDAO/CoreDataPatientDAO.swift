//
//  CoreDataPatientDAO.swift
//  iPark
//
//  Created by Johan BRUNET on 19/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData

class CoreDataPatientDAO: PatientDAO {
    
    private var entityName: String = "Patient"
    private var dao: Patient
    
    init() {
        self.dao = Patient(entity: CoreDataManager.entity(forName: self.entityName), insertInto: CoreDataManager.context)
    }
    
    func insert(patient: PatientModel) throws {
        self.dao.nom_patient = patient.nom
        self.dao.prenom_patient = patient.prenom
        self.dao.adresse = patient.adresse
        self.dao.date_naissance = patient.date_naissance
        do {
            try CoreDataManager.save()
        }
        catch let error as NSError {
            throw error
        }
    }
    
    func update(patient: PatientModel) throws {
        do {
            try self.insert(patient: patient)
        }
        catch let error as NSError {
            throw error
        }
    }
    
    func get() throws -> PatientModel? {
        let req: NSFetchRequest<Patient> = NSFetchRequest(entityName: self.entityName)
        let patients: [Patient] = try self.dao.managedObjectContext!.fetch(req)
        guard let patient: Patient = patients.first else {
            return nil
        }
        return try PatientModel(patient)
    }
}
