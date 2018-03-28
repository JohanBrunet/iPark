//
//  DAOFactory.swift
//  iPark
//
//  Created by Johan BRUNET on 19/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation

class CoreDataDAOFactory {
    
    private static var instance: CoreDataDAOFactory?
    
    private init() {}
    
    static func getInstance() -> CoreDataDAOFactory {
        if CoreDataDAOFactory.instance == nil {
            instance = CoreDataDAOFactory()
        }
        return instance!
    }
    
    func getMedecinDAO() -> MedecinDAO {
        return CoreDataMedecinDAO()
    }
    
    func getActiviteDAO() -> ActiviteDAO {
        return CoreDataActiviteDAO()
    }
    
    func getSpecialiteDAO() -> SpecialiteDAO {
        return CoreDataSpecialiteDAO()
    }
    
    func getTypeActiviteDAO() -> TypeActiviteDAO{
        return CoreDataTypeActiviteDAO()
    }
    
}
