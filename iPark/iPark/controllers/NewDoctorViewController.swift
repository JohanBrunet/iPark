//
//  NewDoctorViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 21/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class NewDoctorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var specialitePicker: UIPickerView!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    var newMed: Medecin? = nil
    var specialites: SpecialiteSet? = nil
    var specialitePicked: Specialite? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.specialites = SpecialiteSet(from: CoreDataDAOFactory.getInstance().getSpecialiteDAO().getAll()!)
        print("nb specialites : ", self.specialites!.count)
        self.specialitePicker.delegate = self
        self.specialitePicker.dataSource = self
        
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
        return self.specialites!.count + 1
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return row == 0 ? "" : self.specialites?.get(row - 1)?.label
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        self.specialitePicked = row == 0 ? nil : self.specialites?.get(row - 1)
    }
    
    @IBAction func submitForm(_ sender: Any) {
        let tab: [UITextField] = [name, address, phone]
        if FormValidator.formIsValid(tab) {
            if checkPhoneNumber(for: phone.text!) {
                guard let spec = self.specialitePicked else {
                    newMed = Medecin(ln: name.text!, addr: address.text!, ph: phone.text!)
                    self.performSegue(withIdentifier: "showPersonalInfos", sender: self)
                    return
                }
                newMed = Medecin(ln: name.text!, addr: address.text!, ph: phone.text!, sp: spec)
                self.performSegue(withIdentifier: "showPersonalInfos", sender: self)
            }
            else {
                let alert = UIAlertController(title: "Téléphone invalide", message: "Veuillez saisir un numéro de téléphone valide", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.phone.text = ""
            }
        }
        else {
            let alert = UIAlertController(title: "Formulaire invalide", message: "Veuillez remplir tous les champs", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func checkPhoneNumber(for number: String) -> Bool {
        let regex = "^0([1-7]|9)[0-9]{8}$"
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = number as NSString
            let results = regex.matches(in: number, options: [], range: NSMakeRange(0, nsString.length))
            return results.count > 0
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PersonalInfoViewController
        destinationVC.medecins?.add(newMed!)
    }
    
}
