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
    
    override func viewDidLoad() {
        super.viewDidLoad()            
            self.proposedActivites = TypeActiviteSet(from: CoreDataDAOFactory.getInstance().getTypeActiviteDAO().getAll()!)
            self.proposedActivities.delegate = self
            self.proposedActivities.dataSource = self

        
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
        cell.activityName.text = activite?.libelle
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.proposedActivites!.remove((self.proposedActivites!.get(indexPath.row))!)
            self.proposedActivities.reloadData()
        }
    }
    
    @IBOutlet weak var durationLastActivity: UILabel!
    @IBOutlet weak var lastActivity: UILabel!
    @IBOutlet weak var dateLastActivity: UILabel!
    
    @IBOutlet weak var proposedActivity: UILabel!
    @IBOutlet weak var activities: UIButton!
    
    @IBOutlet weak var proposedActivities: UITableView!
    
}
