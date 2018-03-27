//
//  DataHelper.swift
//  iPark
//
//  Created by Johan BRUNET on 27/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation

public class DataHelper {
    
    fileprivate static let specDAO: SpecialiteDAO = CoreDataDAOFactory.getInstance().getSpecialiteDAO()
    
    /// Lancer les seeds pour remplir la base de données
    static func seedCoreData() {
        //seedMedicament()
        seedSpecialite()
        specDAO.save()
    }
    
    /// Remplir la base avec la liste des médicaments
//    fileprivate static func seedMedicament(){
//        let medicaments = MedicamentSeeder().medicaments
//
//        for medicament in medicaments {
//            do{
//                let _: Medicament = try Medicament.insert()
//            }catch {
//                fatalError("Error cannot populate DB")
//            }
//        }
//    }
    
    /// Remplir la base avec la liste des types de soignant
    fileprivate static func seedSpecialite(){
        let specialites = SpecialiteSeeder().specialites
        
        for spec in specialites {
            let _: Specialite = specDAO.insert(label: spec)
        }
    }

}