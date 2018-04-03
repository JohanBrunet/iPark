//
//  NewSymptomEventsViewController.swift
//  iPark
//
//  Created by Kevin Giordani on 03/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import UIKit

class NewSymptomEventsViewController: UIViewController {

    @IBOutlet weak var somnolence: UISwitch!
    @IBOutlet weak var chute: UISwitch!
    @IBOutlet weak var priseDispersible: UISwitch!
    @IBOutlet weak var hallucination: UISwitch!
    @IBOutlet weak var clic: UISwitch!
    
    var etat : String? = nil
    var date : NSDate? = nil
    var evenements : [String] = []
    var newSymptome : Symptome? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        somnolence.isOn = false
        chute.isOn = false
        priseDispersible.isOn = false
        hallucination.isOn = false
        clic.isOn = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SymptomsViewController
        destinationVC.symptoms!.add(newSymptome!)
    }
    
    @IBAction func submitForm(_ sender: Any) {
        if somnolence.isOn{
            self.evenements.append("somnolence")
        }
        if chute.isOn{
            self.evenements.append("chute")
        }
        if priseDispersible.isOn{
            self.evenements.append("prise dispersible")
        }
        if hallucination.isOn{
            self.evenements.append("hallucination")
        }
        if clic.isOn{
            self.evenements.append("clic")
        }
        print(evenements)
        self.newSymptome = Symptome(etat: self.etat!, date: self.date!, ev : self.evenements)
        self.performSegue(withIdentifier: "showAllSymptoms", sender: self)
    }
    

}
