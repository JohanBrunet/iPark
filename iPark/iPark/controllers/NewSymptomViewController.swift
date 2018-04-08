//
//  NewSymptomViewController.swift
//  iPark
//
//  Created by Kevin Giordani on 03/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import UIKit

class NewSymptomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.etatSecment.selectedSegmentIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectEvent" {
            let eventsViewController = segue.destination as! NewSymptomEventsViewController
            switch self.etatSecment.selectedSegmentIndex{
            case 0 :
                eventsViewController.etat = "ON"
                break;
            case 1 :
                eventsViewController.etat = "OFF"
                break;
            case 2 :
                eventsViewController.etat = "DYSKINESIE"
                break;
            default:
                eventsViewController.etat = "ON"
            }
            eventsViewController.date = datePicker.date as NSDate
            
            
            
        }
    }

    @IBOutlet weak var etatSecment: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
}
