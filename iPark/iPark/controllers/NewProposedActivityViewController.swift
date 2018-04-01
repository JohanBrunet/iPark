//
//  NewProposedActivityViewController.swift
//  iPark
//
//  Created by Kevin Giordani on 01/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class NewProposedActivityViewController : UIViewController{

    @IBOutlet weak var propositionTextField: UITextField!
    var newTypeActivite : TypeActivite? = nil
    
    @IBAction func addTypeActivite(_ sender: Any) {

        self.newTypeActivite = TypeActivite(nom: propositionTextField.text!)
        self.performSegue(withIdentifier: "showGeneralActivity", sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
