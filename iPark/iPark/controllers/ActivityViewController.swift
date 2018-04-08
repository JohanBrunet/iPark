//
//  ActivityViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 21/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class ActivityViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{
    var proposedActivites : TypeActiviteSet? = nil
    var activiteNull : TypeActivite? = nil
    var activites : ActiviteSet? = nil
    var activitesSemaine : ActiviteSet? = nil
    var mondaysDate: NSDate {
        let iso8601 =  NSCalendar(calendarIdentifier: NSCalendar.Identifier.ISO8601)!
        return iso8601.date(from: iso8601.components([.yearForWeekOfYear, .weekOfYear], from: NSDate() as Date))! as NSDate
    }
    var encouragement :[String] = ["Il est temps de s'y mettre !", "Pas mal, c'est un bon début !", "Super, continuez comme ça !", "Felicitation ! Vous êtes en pleine forme"]
    
    override func viewDidLoad() {
        super.viewDidLoad()            
            self.proposedActivites = TypeActiviteSet(from: CoreDataDAOFactory.getInstance().getTypeActiviteDAO().getAll()!)
            self.proposedActivities.delegate = self
            self.proposedActivities.dataSource = self
            self.activites = ActiviteSet(from: CoreDataDAOFactory.getInstance().getActiviteDAO().getAll()!)
            self.activitesSemaine = activites?.filterByDate(for: mondaysDate as Date, before: false)
            self.displayView()
        
    }
    
    
    func displayView(){
        //Create date formatter
        let formatDate: DateFormatter = DateFormatter()
        var duree: Int32? = nil
        
        //Set date format
        formatDate.dateFormat = "dd/MM/YY hh:mm a"
        
        let lastActivite : Activite? = getLastActivite()
        if lastActivite != nil{
            if lastActivite?.typeActivite == nil {
                 self.lastActivity?.text! = lastActivite!.libelle!
            }
            else {
                self.lastActivity?.text! = lastActivite!.typeActivite!.libelle!
            }
            let date = formatDate.string(from : (lastActivite!.dateActivite as Date))
            self.dateLastActivity?.text! = date
        }
        else{
            self.lastActivity?.text! = ""
            self.dateLastActivity?.text! = ""
        }
        
        duree = getDureeSemaine()
        if duree != nil{
            self.durationLastActivity!.text! = String(Int(duree!))
            if Int(duree!) < 60 && Int(duree!) > 45{
                self.encouragementLabel.text! = encouragement[2]
            }
            else if Int(duree!) < 45 && Int(duree!) > 20{
                self.encouragementLabel.text! = encouragement[1]
            }
            else if Int(duree!) < 20 {
                self.encouragementLabel.text! = encouragement[0]
            }
            else{
                self.encouragementLabel.text! = encouragement[3]
            }
        }
        else{
            self.encouragementLabel.text! = "Enregistrez vite votre première activité !"
        }
        if proposedActivites != nil{
            var count = proposedActivites!.count
            let numeroActivite = Int(arc4random_uniform(UInt32(count)))
            self.proposedActivity!.text! = proposedActivites!.get(numeroActivite)!.libelle!
        }
        
    }
    
    
    
    func getLastActivite() -> Activite? {
        return activites?.getLastActivite()
    }
    
    func getDureeSemaine() -> Int32? {
        if activitesSemaine != nil{
            var duree : Int32 = 0
            for i in 0..<(activitesSemaine!.count){
                duree = duree + activitesSemaine!.get(i)!.dureeActivite
            }
            return duree
        }
        else{
            return nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.proposedActivites!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.proposedActivities.dequeueReusableCell(withIdentifier: "proposedCell", for : indexPath) as! ActiviteCell
        let activite = self.proposedActivites!.get(indexPath.row)
        if activite?.libelle != "Autre Activité"{
        cell.activityName.text = activite?.libelle
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.proposedActivites!.remove((self.proposedActivites!.get(indexPath.row))!)
            self.proposedActivities.reloadData()
        }
        
    }
    
    
    @IBAction func unwindFromAddProposedActivity(segue: UIStoryboardSegue) {
        self.proposedActivites =  TypeActiviteSet(from: CoreDataDAOFactory.getInstance().getTypeActiviteDAO().getAll()!)
        self.proposedActivities.reloadData()
    }
    
    @IBOutlet weak var durationLastActivity: UILabel!
    @IBOutlet weak var lastActivity: UILabel!
    @IBOutlet weak var dateLastActivity: UILabel!
    
    @IBOutlet weak var proposedActivity: UILabel!
    @IBOutlet weak var activities: UIButton!
    @IBOutlet weak var propositionButton: UIButton!
    
    @IBOutlet weak var encouragementLabel: UILabel!
    
    @IBOutlet weak var proposedActivities: UITableView!
    
}
