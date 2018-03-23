//
//  ActivityViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 21/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class ActivityViewController:UIViewController{
    @IBOutlet weak var durationLastActivity: UILabel!
    @IBOutlet weak var lastActivity: UILabel!
    @IBOutlet weak var dateLastActivity: UILabel!
    
    @IBOutlet weak var proposedActivity: UILabel!
    @IBOutlet weak var activities: UIButton!
    
    @IBOutlet weak var proposedActivities: UITableView!
    
}
