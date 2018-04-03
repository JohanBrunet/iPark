//
//  CalendarViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 21/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class CalendarViewController:UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    let PAST_TITLE: String = "Vos précédents rendez-vous"
    let TODAY_TITLE: String = "Vos rendez-vous aujourd'hui"
    let FUTUR_TITLE: String = "Vos prochains rendez-vous"

    @IBOutlet weak var filterButton: UISegmentedControl!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var rdvTableView: UITableView!
    var rdvs: RendezVousSet? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filterButton.selectedSegmentIndex = 1
        self.rdvs = RendezVousSet(from: CoreDataDAOFactory.getInstance().getRendezVousDAO().getAll()!).getTodaysRDV()
        self.rdvs?.sortByDate()
        self.rdvTableView.delegate = self
        self.rdvTableView.dataSource = self
    }

    @IBAction func filterResults(_ sender: Any) {
        switch self.filterButton.selectedSegmentIndex {
        case 0:
            self.pageTitle.text = PAST_TITLE
            self.rdvs =  RendezVousSet(from: CoreDataDAOFactory.getInstance().getRendezVousDAO().getAll()!).filterByDate(for: Date(), before: true)
        case 1:
            self.pageTitle.text = TODAY_TITLE
            self.rdvs =  RendezVousSet(from: CoreDataDAOFactory.getInstance().getRendezVousDAO().getAll()!).getTodaysRDV()
        case 2:
            self.pageTitle.text = FUTUR_TITLE
            self.rdvs =  RendezVousSet(from: CoreDataDAOFactory.getInstance().getRendezVousDAO().getAll()!).filterByDate(for: Date(), before: false)
        default:
            self.pageTitle.text = TODAY_TITLE
            self.rdvs =  RendezVousSet(from: CoreDataDAOFactory.getInstance().getRendezVousDAO().getAll()!).getTodaysRDV()
        }
        
        self.rdvs?.sortByDate()
        self.rdvTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Envoyer le medecin à la vue suivante
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRDVDetails" {
            if let indexPath = self.rdvTableView.indexPathForSelectedRow {
                let appointmentViewController = segue.destination as! MyAppointmentViewController
                appointmentViewController.rdv = self.rdvs?.get(indexPath.row)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rdvs!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RendezVousCell = rdvTableView.dequeueReusableCell(withIdentifier: "rdvCell", for: indexPath) as! RendezVousCell
        let rdv = self.rdvs!.get(indexPath.row)!
        if let med = rdv.med {
            cell.nomMedecin.text! = med.titledName
        }
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.timeZone = NSTimeZone(name: "UTC+1") as TimeZone!
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        // Apply date format
        let dateRDV = dateFormatter.string(from: rdv.dateRDV)
        
        // Change date format
        dateFormatter.dateFormat = "HH:mm"
        let heureRDV = dateFormatter.string(from: rdv.dateRDV)
        
        cell.dateRDV.text = dateRDV
        cell.heureRDV.text = heureRDV
        guard let specialty = rdv.med?.spe else {
            cell.specialiteMedecin.text! = "Non renseigné"
            return cell
        }
        cell.specialiteMedecin.text! = specialty.libelle!
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let rdv: RendezVous = (self.rdvs?.get(indexPath.row))!
            let notifID: String = (rdv.med?.nom)! + DateHelper.formatDate(date: (rdv.dateRDV), pattern: "ddMMyyyyHHmm")
            AppDelegate.notification.removeNotification(identifier: [notifID])
            self.rdvs?.remove(rdv)
            self.rdvTableView.reloadData()
        }
    }
    
    @IBAction func unwindFromAddRDV(segue: UIStoryboardSegue) {
        switch self.filterButton.selectedSegmentIndex {
        case 0:
            self.pageTitle.text = PAST_TITLE
            self.rdvs =  RendezVousSet(from: CoreDataDAOFactory.getInstance().getRendezVousDAO().getAll()!).filterByDate(for: Date(), before: true)
        case 1:
            self.pageTitle.text = TODAY_TITLE
            self.rdvs =  RendezVousSet(from: CoreDataDAOFactory.getInstance().getRendezVousDAO().getAll()!).getTodaysRDV()
        case 2:
            self.pageTitle.text = FUTUR_TITLE
            self.rdvs =  RendezVousSet(from: CoreDataDAOFactory.getInstance().getRendezVousDAO().getAll()!).filterByDate(for: Date(), before: false)
        default:
            self.pageTitle.text = TODAY_TITLE
            self.rdvs =  RendezVousSet(from: CoreDataDAOFactory.getInstance().getRendezVousDAO().getAll()!).getTodaysRDV()
        }
        
        self.rdvs?.sortByDate()
        self.rdvTableView.reloadData()
    }

}
