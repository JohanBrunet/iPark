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
    private static var coreDataInstance: Patient?
    internal static var instance: CoreDataPatientDAO?
    
    private init() {}
    
    static func getInstance() -> CoreDataPatientDAO {
        if CoreDataPatientDAO.instance == nil {
            instance = CoreDataPatientDAO()
            if CoreDataPatientDAO.coreDataInstance == nil {
                CoreDataPatientDAOcoreDataInstance = Patient(entity: CoreDataManager.entity(forName: self.entityName), insertInto: CoreDataManager.context)
            }
        }
        return instance!
    }
    
    func insert(lastName: String, firstName: String, adress: String, birthdate: NSDate?) throws {
        self.coreDataInstance!.nom_patient = lastName
        self.coreDataInstance!.prenom_patient = firstName
        self.coreDataInstance!.adresse = adress
        self.coreDataInstance!.date_naissance = birthdate
        do {
            try CoreDataManager.save()
        }
        catch let error as NSError {
            throw error
        }
    }
    
    func getLastName() -> String {
        return self.coreDataInstance!.nom_patient!
    }
    
    func getFirstName() -> String {
        return self.coreDataInstance!.prenom_patient!
    }
    
    func getAdress() -> String {
        return self.coreDataInstance!.adresse!
    }
    
    func getBirthdate() -> NSDate {
        return self.coreDataInstance!.date_naissance!
    }
    
    func setLastName(lastName: String) {
        self.coreDataInstance!.nom_patient = lastName
    }
    
    func setFirstName(firstName: String) {
        self.coreDataInstance!.prenom_patient = firstName
    }
    
    func setAdress(adress: String) {
        self.coreDataInstance!.adresse = adress
    }
    
}
