//
//  PillsViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 23/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class PillsViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var PageLabel: UILabel!
    @IBOutlet weak var pillsTableView: UITableView!
    @IBOutlet weak var AddMedicationButton: UIButton!
    
    var day: Date = DateHelper.truncateToDay(from: Date())
    var medications : PriseSet? = nil
    
    override func viewDidLoad() {
        self.medications = PriseSet(from: CoreDataDAOFactory.getInstance().getPriseDAO().getAll()!).getTodaysPrises()
        self.medications?.sortByDate()
        self.displayDate()
        self.pillsTableView.delegate = self
        self.pillsTableView.dataSource = self
    }
    
    func displayDate() {
        self.dateLabel.text = DateHelper.formatDate(date: self.day, pattern: "EEEE dd MMMM yyyy")
    }
    
    @IBAction func previousDay(_ sender: Any) {
        self.day = DateHelper.getPreviousDay(from: self.day)
        self.displayDate()
        self.medications = PriseSet(from: CoreDataDAOFactory.getInstance().getPriseDAO().getAll()!).filterByDate(forDate: self.day)
        self.medications?.sortByDate()
        print("taille set : " + (self.medications?.count.description)!)
        self.pillsTableView.reloadData()
    }
    
    @IBAction func nextDay(_ sender: Any) {
        self.day = DateHelper.getNextDay(from: self.day)
        self.displayDate()
        self.medications = PriseSet(from: CoreDataDAOFactory.getInstance().getPriseDAO().getAll()!).filterByDate(forDate: self.day)
        self.medications?.sortByDate()
        print("taille set : " + (self.medications?.count.description)!)
        self.pillsTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("nb cellules : " + (self.medications?.count.description)!)
        return (self.medications?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Création cellule n°" + indexPath.row.description)
        let cell: PriseTableViewCell = pillsTableView.dequeueReusableCell(withIdentifier: "priseCell", for: indexPath) as! PriseTableViewCell
        let prise: Prise = (self.medications?.get(indexPath.row))!
        cell.heure.text = DateHelper.formatDate(date: prise.rappelPrise, pattern: "HH:mm")
        cell.medicament.text = prise.toText
        
        switch prise.etat {
        case "PRISE":
            cell.imageEtat.image = #imageLiteral(resourceName: "success")
            break
        case "EN_ATTENTE":
            cell.imageEtat.image = nil
            break
        case "NON_PRISE":
            print("non prise")
            cell.imageEtat.image = #imageLiteral(resourceName: "error")
            break
        default:
            cell.imageEtat.image = nil
            break
        }
        
        return cell
    }
    
    // MARK: - to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let prise: Prise = (self.medications?.get(indexPath.row))!
            let notifID: String = prise.med.nom + DateHelper.formatDate(date: prise.rappelPrise, pattern: "ddMMyyyyHHmm")
            AppDelegate.notification.removeNotification(identifier: [notifID])
            self.medications?.remove(prise)
            self.pillsTableView.reloadData()
        }
    }
    
    @IBAction func unwindFromAddPrise(segue: UIStoryboardSegue) {
        self.day = DateHelper.truncateToDay(from: Date())
        self.displayDate()
        self.medications = PriseSet(from: CoreDataDAOFactory.getInstance().getPriseDAO().getAll()!).getTodaysPrises()
        self.medications?.sortByDate()
        self.pillsTableView.reloadData()
    }

}
