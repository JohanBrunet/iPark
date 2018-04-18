//
//  HomeViewController.swift
//  iPark
//
//  Created by Johan BRUNET on 10/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import UIKit

class HomeViewController:UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var medicamentLabel: UILabel!
    @IBOutlet weak var horaireLabel: UILabel!
    @IBOutlet weak var nomDocteurLabel: UILabel!
    @IBOutlet weak var nomActiviteLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    func loadData() {
        usernameLabel.text = "Bonjour " + UserDefaults.standard.string(forKey: "prenom")!
        self.displayLastPrise()
        self.displayNextRDV()
        self.displayActiviteProposee()
    }
    
    func displayLastPrise() {
        let prises = PriseSet(from : CoreDataDAOFactory.getInstance().getPriseDAO().getAll()).filterByDate(forDate: Date(), before: true)
        if prises.count > 0 {
            prises.sortByDate()
            let nextPrise = prises.get(prises.count - 1)
            self.horaireLabel.text = DateHelper.formatDate(date: (nextPrise?.rappelPrise)!, pattern: " HH:mm")
            self.medicamentLabel.text = nextPrise?.toText
        }
    }
    
    func displayNextRDV() {
        let rdvs = RendezVousSet(from : CoreDataDAOFactory.getInstance().getRendezVousDAO().getAll()).filterByDate(for: Date(), before: false)
        if rdvs.count > 0 {
            rdvs.sortByDate()
            let rdv = rdvs.get(0)
            if rdv != nil{
                self.nomDocteurLabel!.text! = " " + rdv!.med!.nom
                self.dateLabel!.text! = DateHelper.formatDate(date: rdv!.dateRDV, pattern: "dd/MM/yyyy à HH:mm")
            }
        }
    }
    
    func displayActiviteProposee() {
        let proposedActivites = TypeActiviteSet(from : CoreDataDAOFactory.getInstance().getTypeActiviteDAO().getAll())
        if proposedActivites.count > 0 {
            let numeroActivite = Int(arc4random_uniform(UInt32(proposedActivites.count)))
            self.nomActiviteLabel!.text! = proposedActivites.get(numeroActivite)!.libelle!
        }
        else{
            self.nomActiviteLabel!.text! = "Sport"
        }
    }

}
