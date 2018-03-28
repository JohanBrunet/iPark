//
//  PersonalInfoViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 20/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class PersonalInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var filterButton: UISegmentedControl!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var medecinTableView: UITableView!
    
    var medecins: MedecinSet? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayPatientInfos()
        
        self.filterButton.selectedSegmentIndex = 0
        self.medecins = MedecinSet(from: CoreDataDAOFactory.getInstance().getMedecinDAO().getAll()!)
        self.medecins?.sortByName()
        self.medecinTableView.delegate = self
        self.medecinTableView.dataSource = self
    }
    
    @IBAction func filterValues(_ sender: Any) {
        switch self.filterButton.selectedSegmentIndex {
            case 0:
                self.medecins?.sortByName()
            case 1:
                self.medecins?.sortBySpecialite()
            default:
                self.medecins?.sortByName()
        }
        self.medecinTableView.reloadData()
    }
    
    func displayPatientInfos() {
        self.fullName.text = UserDefaults.standard.string(forKey: "prenom")! + " " + UserDefaults.standard.string(forKey: "nom")!
        self.adress.text = UserDefaults.standard.string(forKey: "adresse")!
        let birthdate: Date = UserDefaults.standard.object(forKey: "date_naissance") as! Date
        let today: Date = Date()
        let age: Int = Calendar.current.dateComponents([.year], from: birthdate, to: today).year!
        self.age.text = age.description + " ans"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Envoyer le medecin à la vue suivante
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDoctorView" {
            if let indexPath = self.medecinTableView.indexPathForSelectedRow {
                let medecinViewController = segue.destination as! DoctorViewController
                medecinViewController.medecin = self.medecins?.get(indexPath.row)
                medecinViewController.posMedecin = indexPath.row
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.medecins!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MedecinCell = medecinTableView.dequeueReusableCell(withIdentifier: "medecinCell", for: indexPath) as! MedecinCell
        let med = self.medecins!.get(indexPath.row)!
        cell.name.text! = med.titledName
        guard let specialty = med.specialite else {
            cell.specialty.text! = "Non renseigné"
            return cell
        }
        cell.specialty.text! = specialty.libelle!
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.medecins?.remove((self.medecins?.get(indexPath.row))!)
            self.medecinTableView.reloadData()
        }
    }
    
    @IBAction func unwindFromAddMedecin(segue: UIStoryboardSegue) {
        switch self.filterButton.selectedSegmentIndex {
            case 0:
                self.medecins?.sortByName()
            case 1:
                self.medecins?.sortBySpecialite()
            default:
                self.medecins?.sortByName()
        }
        self.medecinTableView.reloadData()
    }
    
    @IBAction func unwindFromDeleteMedecin(segue: UIStoryboardSegue) {
        switch self.filterButton.selectedSegmentIndex {
            case 0:
                self.medecins?.sortByName()
            case 1:
                self.medecins?.sortBySpecialite()
            default:
                self.medecins?.sortByName()
        }
        self.medecinTableView.reloadData()
    }
    
}
