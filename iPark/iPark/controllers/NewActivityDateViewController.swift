//
//  NewActivityDateViewController.swift
//  iPark
//
//  Created by Kevin Giordani on 01/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class NewActivityDateViewController : UIViewController{
    
    @IBOutlet weak var remarqueTextArea: UITextView!
    @IBOutlet weak var dureeTextField: UITextField!
    @IBOutlet weak var activityDatePicker: UIDatePicker!
    
    var newActivite: Activite? = nil
    var typeActivite: TypeActivite? = nil
    var nomActivite: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitForm(_ sender: Any) {
        let date = (self.activityDatePicker?.date != nil) ? self.activityDatePicker.date : Date()
        let dureeActivite = self.dureeTextField?.text
        let remarqueActivite = self.remarqueTextArea?.text
        if typeActivite == nil{
                self.newActivite = Activite( la: nomActivite!, dur: Int32(dureeActivite!)!, date: date as NSDate!, rem: remarqueActivite)
        }
        else{
            self.newActivite = Activite( la: typeActivite!.libelle! , dur: Int32(dureeActivite!)!, date: date as NSDate!, rem: remarqueActivite)
        }
        self.performSegue(withIdentifier: "showAllActivities", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MyActivitiesViewController
        destinationVC.activites?.add(newActivite!)
    }
    
    
}
