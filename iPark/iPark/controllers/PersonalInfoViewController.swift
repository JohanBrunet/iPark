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
   
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var medecinTableView: UITableView!
    
    var medecinSet: MedecinSet? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayPatientInfos()
        
        self.medecinSet = MedecinSet(from: CoreDataDAOFactory.getInstance().getMedecinDAO().getAll()!)
        print("nb meds : ", self.medecinSet!.count)
        self.medecinTableView.delegate = self
        self.medecinTableView.dataSource = self
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
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let indexPath = self.medecinTableView.indexPathForSelectedRow {
//            let medecinViewController = segue.destination as! DoctorViewController
//            medecinViewController.medecin = self.medecinSet[indexPath.row]
//            medecinViewController.posMedecin = indexPath.row
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("nb cells to create : ", self.medecinSet!.count)
        return self.medecinSet!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MedecinCell = medecinTableView.dequeueReusableCell(withIdentifier: "medecinCell", for: indexPath) as! MedecinCell
        let med = self.medecinSet!.get(indexPath.row)!
        print(med)
        cell.name.text! = med.titledName
        guard let specialty = med.specialite else {
            cell.specialty.text = ""
            return cell
        }
        cell.specialty.text! = specialty.libelle!

        return cell
    }
    
    @IBAction func unwindFromAddMedecin(segue: UIStoryboardSegue) {
        self.medecinTableView.reloadData()
    }
    
}
