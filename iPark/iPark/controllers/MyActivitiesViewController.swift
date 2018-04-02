//
//  MyActivitiesViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 21/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import UserNotifications

class MyActivitiesViewController:UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var PageLabel: UILabel!
    @IBOutlet weak var AddActivityButton: UIButton!
    @IBOutlet weak var LastActivities: UITableView!
    
    var activites: ActiviteSet? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activites = ActiviteSet(from: CoreDataDAOFactory.getInstance().getActiviteDAO().getAll())
        self.LastActivities.delegate = self
        self.LastActivities.dataSource = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.activites!.count
    }
    
    /// à faire lorsque l'on aura la vue remarque
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDoctorView" {
            if let indexPath = self.medecinTableView.indexPathForSelectedRow {
                let medecinViewController = segue.destination as! DoctorViewController
                medecinViewController.medecin = self.medecins?.get(indexPath.row)
                medecinViewController.posMedecin = indexPath.row
            }
        }
    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Create date formatter
        let formatDate: DateFormatter = DateFormatter()
        
        //Set date format
        formatDate.dateFormat = "dd/MM/YY hh:mm a"
        
        let cell: LastActiviteCell = LastActivities.dequeueReusableCell(withIdentifier: "activiteCell", for: indexPath) as! LastActiviteCell
        let act = self.activites!.get(indexPath.row)!
        if (act.nomActivite != nil){
            cell.nomActiviteLabel.text! = act.nomActivite!
        }
        else {
            cell.nomActiviteLabel.text! = act.typeActivite!.libelle!
        }
        let date = formatDate.string(from : (act.dateActivite as Date))
        cell.dateActiviteLabel.text! = date
        cell.dureeActiviteLabel.text! = String (act.dureeActivite)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.activites?.remove((self.activites?.get(indexPath.row))!)
            self.LastActivities.reloadData()
        }
    }
    
    @IBAction func unwindFromAddActivite(segue: UIStoryboardSegue) {
        self.activites =  ActiviteSet(from: CoreDataDAOFactory.getInstance().getActiviteDAO().getAll())
        self.LastActivities.reloadData()
    }
    
    @IBAction func unwindFromDeleteActivite(segue: UIStoryboardSegue) {
        self.LastActivities.reloadData()
    }
    
    
}





