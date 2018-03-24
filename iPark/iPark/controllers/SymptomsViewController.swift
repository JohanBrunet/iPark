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
    
    var symptoms : [String] = ["On"]
    
    @IBOutlet weak var PageLabel: UILabel!
    @IBOutlet weak var AddSymptoms: UIButton!
    @IBOutlet weak var SymptomsTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.symptoms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SymptomsTableView.dequeueReusableCell(withIdentifier: "SymptomCell", for : indexPath) as! SymptomTableViewCell
        return cell
    }
}
