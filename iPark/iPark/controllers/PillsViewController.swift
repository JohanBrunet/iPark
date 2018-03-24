//
//  PillsViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 23/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class PillsViewController:UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var medications : [String] = ["Advil","Doliprane"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.medications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = PillsTableView.dequeueReusableCell(withReuseIdentifier: "MedicationCell", for: indexPath) as! MedicationCollectionViewCell
        cell.MedicamentLabel.text = medications[indexPath.row]
        return cell
    }
    

    
    @IBOutlet weak var PageLabel: UILabel!
    @IBOutlet weak var PillsTableView: UICollectionView!
    @IBOutlet weak var AddMedicationButton: UIButton!
    
}
