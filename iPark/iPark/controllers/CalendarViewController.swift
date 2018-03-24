//
//  CalendarViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 21/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class CalendarViewController:UIViewController,  UITableViewDelegate, UITableViewDataSource{
    var appointments : [String] = ["Martin","Dupont"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.appointmentTableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for : indexPath) as! AppointmentTableViewCell
        cell.DoctorNameLabel.text = self.appointments[indexPath.row]
        return cell
    }
    
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var appointmentTableView: UITableView!
    @IBOutlet weak var addAppointment: UIButton!
    
}
