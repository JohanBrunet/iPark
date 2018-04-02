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
    fileprivate static let typeActDAO: TypeActiviteDAO = CoreDataDAOFactory.getInstance().getTypeActiviteDAO()
    fileprivate static let medicamentDAO: MedicamentDAO = CoreDataDAOFactory.getInstance().getMedicamentDAO()

    
    /// Lancer les seeds pour remplir la base de données
    static func seedCoreData() {
        seedMedicament()
        seedSpecialite()
        seedTypeActivite()
        CoreDataManager.save()
        print("\n CoreData seeded \n")
    }
    
    /// Remplir la base avec la liste des médicaments
    fileprivate static func seedMedicament(){
        let medicaments = MedicamentSeeder().medicaments

        for medicament in medicaments {
            let _: Medicament = medicamentDAO.insert(forName: medicament.nom, withDoses: medicament.doses)
        }
    }
    
    /// Remplir la base avec la liste des types de soignant
    fileprivate static func seedSpecialite(){
        let specialites = SpecialiteSeeder().specialites
        
        for spec in specialites {
            let _: Specialite = specDAO.insert(label: spec)
        }
    }
    
    
    /// Remplir la base avec des activités proposées de baset
    fileprivate static func seedTypeActivite(){
        let typeActivites = TypeActiviteSeeder().typeActivites
        
        for typAct in typeActivites {
            let _: TypeActivite = typeActDAO.insert(nomActivite: typAct)
        }
    }

}
