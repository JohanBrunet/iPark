//
//  MyActivitiesViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 21/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class MyActivitiesViewController:UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var PageLabel: UILabel!
    @IBOutlet weak var AddActivityButton: UIButton!
    @IBOutlet weak var LastActivities: UITableView!
    
    var activities : [String] = ["Piscine","Jogging"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LastActivities.dequeueReusableCell(withIdentifier:"LastActivity", for : indexPath) as! LastActivityTableViewCell
        cell.ActivityNameLabel.text = self.activities[indexPath.row]
        return cell
    }
}
