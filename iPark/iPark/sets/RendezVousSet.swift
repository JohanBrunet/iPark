//
//  RendezVousSet.swift
//  iPark
//
//  Created by Johan BRUNET on 27/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation

class RendezVousSet {
    
    fileprivate var rdvSet: [RendezVous] = []
    let rdvDAO: RendezVousDAO = CoreDataDAOFactory.getInstance().getRendezVousDAO()
    
    var count: Int {
        return self.rdvSet.count
    }
    
    init(from rendezvous: [RendezVous]?) {
        if let rdvs = rendezvous {
            for rdv in rdvs {
                self.rdvSet.append(rdv)
            }
        }
    }
    
    @discardableResult
    func add(_ rdv: RendezVous) -> RendezVousSet {
        if !self.contains(rdv) {
            self.rdvSet.append(rdv)
            self.rdvDAO.add(rdv)
        }
        return self
    }
    
    @discardableResult
    func remove(_ rdv: RendezVous) -> RendezVousSet {
        if self.contains(rdv) {
            self.rdvSet.remove(at: self.rdvSet.index(of: rdv)!)
            self.rdvDAO.delete(for: rdv)
        }
        return self
    }
    
    func get(_ i: Int) -> RendezVous? {
        if(i < 0 || i >= rdvSet.count){
            return nil
        }
        return self.rdvSet[i]
    }
    
    // Récupérer le dernier rendez-vous (avant la date d'aujourd'hui)
    func getLastForMed(for medecin: Medecin) -> RendezVous? {
        var lastRDVForMed: RendezVous? = nil
        let filteredSetMed = self.filterByMedecin(for: medecin)
        if filteredSetMed.count > 0 {
            let filteredSetDate = filteredSetMed.filterByDate(for: Date(), before: true)
            if filteredSetDate.count > 0 {
                filteredSetDate.sortByDate()
                lastRDVForMed = filteredSetDate.get(filteredSetDate.count - 1)
            }
        }
        return lastRDVForMed
    }
    
    func filterByMedecin(for medecin: Medecin) -> RendezVousSet {
        return RendezVousSet(from: self.rdvSet.filter { $0.medecin == medecin })
    }
    
    func contains(_ rdv: RendezVous) -> Bool {
        return self.rdvSet.contains(where: {$0==rdv})
    }
    
    func filterByDate(for date: Date, before: Bool) -> RendezVousSet {
        if before {
            return RendezVousSet(from: self.rdvSet.filter { DateHelper.truncateToDay(from: $0.dateRDV) < DateHelper.truncateToDay(from: date) })
        }
        else {
            return RendezVousSet(from: self.rdvSet.filter { DateHelper.truncateToDay(from: $0.dateRDV) > DateHelper.truncateToDay(from: date) })
        }
    }
    
    func getTodaysRDV() -> RendezVousSet {
        return RendezVousSet(from: self.rdvSet.filter { DateHelper.truncateToDay(from: $0.dateRDV) == DateHelper.truncateToDay(from: Date()) })
    }
    
    func sortByDate() {
        return self.rdvSet.sort(by: { (rdv1, rdv2) -> Bool in
            rdv1.dateRDV < rdv2.dateRDV
        })
    }
    
}
