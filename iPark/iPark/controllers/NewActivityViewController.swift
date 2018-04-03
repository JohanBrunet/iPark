//
//  NewActivityViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 23/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class NewActivityViewController:UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var newActivite: Activite? = nil
    var noActivite: String = "Autre Activité"
    var activites: TypeActiviteSet? = nil
    var activitePicked: TypeActivite? = nil
    
    @IBOutlet weak var activityTextField: UITextField!
    @IBOutlet weak var activityPickerView: UIPickerView!
    @IBOutlet weak var newActivityButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tempActivites: [TypeActivite] = CoreDataDAOFactory.getInstance().getTypeActiviteDAO().getAll()!
        self.activites = TypeActiviteSet(from:tempActivites)
        self.activites?.sortByName()
        self.activityPickerView.delegate = self
        self.activityPickerView.dataSource = self
        
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.activites!.count + 1
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == activites!.count {
            return "Autre Activité"
        }
        else {
            return self.activites?.get(row)?.libelle
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        self.activitePicked = self.activites?.get(row)
    }
    
    // MARK: - Envoyer l'activité à la vue suivante
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectActivityDate" {
            let dateActivityViewController = segue.destination as! NewActivityDateViewController
            if ((self.activitePicked) != nil){
                if self.activitePicked!.libelle! != noActivite{
                    dateActivityViewController.typeActivite = self.activitePicked!
                }
                else{
                    dateActivityViewController.nomActivite = activityTextField.text!
                }
            }
            else{
                dateActivityViewController.nomActivite = activityTextField.text!
            }
            

        }
    }
}
