//
//  NewMedicationViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 23/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class NewMedicationViewController:UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperValue: UILabel!
    @IBOutlet weak var medicamentPicker: UIPickerView!
    @IBOutlet weak var dosagePicker: UIPickerView!
    var medicaments: MedicamentSet? = nil
    var medicamentPicked: Medicament? = nil
    var dosePicked: String? = nil
    
    override func viewDidLoad() {
        self.medicaments = MedicamentSet(from: CoreDataDAOFactory.getInstance().getMedicamentDAO().getAll()!)
        self.medicaments?.sortByName()
        self.medicamentPicked = self.medicaments?.get(0)
        
        self.stepper.minimumValue = 0
        self.stepper.maximumValue = 10
        self.stepper.autorepeat = true
        self.stepperValue.text = Int(self.stepper.value).description

        self.medicamentPicker.delegate = self
        self.medicamentPicker.dataSource = self
        self.dosagePicker.delegate = self
        self.dosagePicker.dataSource = self
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        self.stepperValue.text = Int(sender.value).description
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
        if pickerView == medicamentPicker {
            return (self.medicaments?.count)!
        }
        else {
            
            return (self.medicamentPicked?.doses.count)!
        }
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == medicamentPicker {
            return self.medicaments?.get(row)?.nom
        }
        else {
            return self.medicamentPicked?.doses[row]
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        if pickerView == medicamentPicker {
            self.medicamentPicked = self.medicaments?.get(row)
            dosagePicker.reloadAllComponents()
        }
        else {
            self.dosePicked = self.medicamentPicked?.doses[row]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! NewMedicationRappelViewController
        destinationVC.medicament = self.medicamentPicked
        destinationVC.dose = (self.dosePicked != nil) ? self.dosePicked : self.medicamentPicked?.doses[0]
        destinationVC.quantite = Int(self.stepper.value).description
    }
    
}
