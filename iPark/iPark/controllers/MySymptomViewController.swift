//
//  MySymptomViewController.swift
//  iPark
//
//  Created by Kevin Giordani on 03/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import UIKit

class MySymptomViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var etatLabel: UILabel!
    @IBOutlet weak var event1Label: UILabel!
    @IBOutlet weak var event2Label: UILabel!
    @IBOutlet weak var event3Label: UILabel!
    @IBOutlet weak var event4Label: UILabel!
    @IBOutlet weak var event5Label: UILabel!
    
    var etat: String? = nil
    var date: NSDate? = nil
    var evenements: [String] = []
    var symptom : Symptome? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        event1Label.text! = ""
        event2Label.text! = ""
        event3Label.text! = ""
        event4Label.text! = ""
        event5Label.text! = ""
        
        if symptom?.evenementsSignal != nil {
                self.evenements = symptom!.evenementsSignal!
        }

        self.etatLabel.text! = etat!
        let dateFormatted = DateHelper.formatDate(date: (date as! Date), pattern: "dd MMMM yyyy à HH:mm")
        self.dateLabel.text = dateFormatted
        let i = evenements.count
        if i >= 1{
            event1Label.text! = evenements[0]
            if i >= 2{
                event2Label.text! = evenements[1]
                if i >= 3{
                    event3Label.text! = evenements[2]
                    if i >= 4{
                        event4Label.text! = evenements[3]
                        if i >= 5{
                            event5Label.text! = evenements[4]
                                
                        }
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
