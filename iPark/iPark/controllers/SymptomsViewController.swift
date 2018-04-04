//
//  SymptomsViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 23/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class SymptomsViewController:UIViewController, UITableViewDataSource, UICollectionViewDelegate{
    
    var symptoms : SymptomeSet? = nil
    
    @IBOutlet weak var PageLabel: UILabel!
    @IBOutlet weak var AddSymptoms: UIButton!
    @IBOutlet weak var SymptomsTableView: UITableView!
    
    override func viewDidLoad() {
        if !rdvNeuroInFiveDays() {
            self.AddSymptoms.isHidden = true
        }
        symptoms = SymptomeSet( from : CoreDataDAOFactory.getInstance().getSymptomeDAO().getAll())
        SymptomsTableView.reloadData()
    }
    
    func rdvNeuroInFiveDays() -> Bool{
        var isBetween: Bool = false
        let nextRDVsNeuro = RendezVousSet(from: CoreDataDAOFactory.getInstance().getRendezVousDAO().getAll()).filterBySpecialite(for: "neurologue").filterByDate(for : Date(), before: false)
        if nextRDVsNeuro.count > 0 {
            nextRDVsNeuro.sortByDate()
            let nextRDVNeuro = nextRDVsNeuro.get(0)
            let nextRDVNeuroDate = DateHelper.truncateToDay(from: (nextRDVNeuro?.dateRDV)!)
            let fiveDaysBefore = DateHelper.truncateToDay(from: DateHelper.addDays(add: -5, to: (nextRDVNeuro?.dateRDV)!))
            isBetween = (fiveDaysBefore ... nextRDVNeuroDate).contains(DateHelper.truncateToDay(from: Date()))
        }
        return isBetween
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.symptoms?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SymptomsTableView.dequeueReusableCell(withIdentifier: "SymptomTableViewCell", for : indexPath) as! SymptomTableViewCell
        cell.etatLabel.text! = (symptoms!.get(indexPath.row)?.etat)!
        let dateFormatted = DateHelper.formatDate(date: (self.symptoms!.get(indexPath.row)?.date as! Date), pattern: "dd/MM/yy à HH:mm")
        cell.dateLabel.text = dateFormatted
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let symp: Symptome = (self.symptoms?.get(indexPath.row))!
            self.symptoms?.remove(symp)
            self.SymptomsTableView.reloadData()
        }
    }
    
    @IBAction func unwindFromAddSymptom(segue: UIStoryboardSegue){
        SymptomsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showSymptom" {
            if let indexPath = self.SymptomsTableView.indexPathForSelectedRow {
                let mySymptomViewController = segue.destination as! MySymptomViewController
                mySymptomViewController.etat = self.symptoms?.get(indexPath.row)?.etatPatient
                mySymptomViewController.date = self.symptoms?.get(indexPath.row)?.dateSymptome
                /*if self.symptoms!.get(indexPath.row)!.evenements != nil{
                    mySymptomViewController.evenements = self.symptoms!.get(indexPath.row)!.evenements as! [String]
                }*/
                mySymptomViewController.symptom = self.symptoms!.get(indexPath.row)!
            }
        }
    }
}
