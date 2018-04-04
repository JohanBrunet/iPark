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
    
    var proposedActivites : TypeActiviteSet? = nil
    
    var rdvs : RendezVousSet? = nil
    
    var prises : PriseSet? = nil

    
    override func viewDidLoad() {
        usernameLabel.text = "Bonjour " + UserDefaults.standard.string(forKey: "prenom")!
        
        proposedActivites = TypeActiviteSet(from : CoreDataDAOFactory.getInstance().getTypeActiviteDAO().getAll())
        
        rdvs = RendezVousSet(from : CoreDataDAOFactory.getInstance().getRendezVousDAO().getAll())
        
        prises = PriseSet(from : CoreDataDAOFactory.getInstance().getPriseDAO().getAll())
        
        if proposedActivites != nil{
            var count = proposedActivites!.count
            let numeroActivite = Int(arc4random_uniform(UInt32(count)))
            self.nomActiviteLabel!.text! = proposedActivites!.get(numeroActivite)!.libelle!
        }
        else{
            self.nomActiviteLabel!.text! = "Sport"
        }
        let rdv = rdvs?.filterByDate(for: Date(), before: false).get(0)
        
        
        //Create date formatter
        let formatDate: DateFormatter = DateFormatter()
        
        //Set date format
        formatDate.dateFormat = "dd/MM/yyyy à HH:mm "
        
        if rdv != nil{
            self.nomDocteurLabel!.text! = rdv!.med!.nom
            
            
            self.dateLabel!.text! = formatDate.string(from: rdv!.dateRDV)
            
        }
        
    }

}
