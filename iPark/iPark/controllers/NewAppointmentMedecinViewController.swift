//
//  NewAppointmentViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 21/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class NewAppointmentMedecinViewController:UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var medecinPicker: UIPickerView!
    
    var newRDV: RendezVous? = nil
    var medecins: MedecinSet? = nil
    var medecinPicked: Medecin? = nil
    
    override func viewDidLoad() {
    super.viewDidLoad()
    self.medecins = MedecinSet(from: CoreDataDAOFactory.getInstance().getMedecinDAO().getAll()!)
    self.medecinPicker.delegate = self
    self.medecinPicker.dataSource = self
    
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
    return self.medecins!.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return self.medecins?.get(row)?.titledName
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        self.medecinPicked = self.medecins?.get(row)
    }
    
    // MARK: - Envoyer le medecin à la vue suivante
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectRDVDate" {
            let dateRDVViewController = segue.destination as! NewAppointmentDateViewController
            dateRDVViewController.medecin = (self.medecinPicked != nil) ? self.medecinPicked : self.medecins?.get(0)
        }
    }
}
