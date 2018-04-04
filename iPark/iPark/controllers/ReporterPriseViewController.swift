//
//  ReporterPriseViewController.swift
//  iPark
//
//  Created by Johan BRUNET on 04/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class ReporterPriseViewController: UIViewController {
    
    @IBOutlet weak var heureDecalagePrise: UIDatePicker!
    
    var priseAReporter: Prise? = nil
    var newPrise: Prise? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heureDecalagePrise.countDownDuration = 0
        self.heureDecalagePrise.locale = Locale(identifier: "fr_FR")
    }

    @IBAction func reporterPrise(_ sender: Any) {
        let tempsPrep = self.heureDecalagePrise.countDownDuration
        let nouveauRappel = self.priseAReporter?.rappelPrise.addingTimeInterval(tempsPrep)
        self.newPrise = Prise(forMed: (self.priseAReporter?.med)!, withDose: (self.priseAReporter?.doseMed)!, withQuant: (self.priseAReporter?.quantiteMed)!, at: nouveauRappel!)
        self.performSegue(withIdentifier: "decalerPrise", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PillsViewController
        destinationVC.medications?.add(self.newPrise!)
    }
    
}
