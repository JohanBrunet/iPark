//
//  ValiderPriseViewController.swift
//  iPark
//
//  Created by Johan BRUNET on 04/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class ValiderPriseViewController: UIViewController {
    
    
    @IBOutlet weak var heurePrise: UILabel!
    @IBOutlet weak var detailPrise: UILabel!
    
    var priseAValider: Prise? = nil
    
    override func viewDidLoad() {
        self.heurePrise.text = DateHelper.formatDate(date: (self.priseAValider?.rappelPrise)!, pattern: "HH:mm")
        self.detailPrise.text = self.priseAValider?.toText
    }
    
    @IBAction func validerPrise(_ sender: Any) {
        self.priseAValider?.estPrise = true
        CoreDataManager.save()
        self.performSegue(withIdentifier: "priseValidee", sender: self)
    }
    
    // MARK: - Envoyer la prise
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reporterPrise" {
            let reporterPriseVC = segue.destination as! ReporterPriseViewController
            reporterPriseVC.priseAReporter = self.priseAValider
        }
    }
}
