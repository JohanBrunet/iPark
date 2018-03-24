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
    var testActivities : [String] = ["Piscine", "Marche à pied"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.testActivities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.proposedActivities.dequeueReusableCell(withIdentifier: "ActivityCell", for : indexPath) as! ActivityTableViewCell
        cell.activityName.text = self.testActivities[indexPath.row]
        return cell
    }
    
    @IBOutlet weak var durationLastActivity: UILabel!
    @IBOutlet weak var lastActivity: UILabel!
    @IBOutlet weak var dateLastActivity: UILabel!
    
    @IBOutlet weak var proposedActivity: UILabel!
    @IBOutlet weak var activities: UIButton!
    
    @IBOutlet weak var proposedActivities: UITableView!
    
}
