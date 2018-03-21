//
//  File.swift
//  iPark
//
//  Created by Johan BRUNET on 19/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation

protocol PatientDAO {

    func get() throws -> Patient?
    func insert(patient: PatientModel) throws
    func update(patient: PatientModel) throws
    func delete(patient: PatientModel)
    
}
