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
    
    
    @IBOutlet weak var PageLabel: UILabel!
    @IBOutlet weak var pillsTableView: UICollectionView!
    @IBOutlet weak var AddMedicationButton: UIButton!
    
    var medications : PriseSet? = nil
    
    override func viewDidLoad() {
        self.medications = PriseSet(from: CoreDataDAOFactory.getInstance().getPriseDAO().getAll()!)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var nbCells: Int = 0
        if self.medications?.count != 0 {
            for i in 0...((self.medications?.count)! - 1) {
                let previous = (i > 0) ? self.medications?.get(i - 1) : self.medications?.get(i)
                if DateHelper.truncateToHour(from: (self.medications?.get(i)?.rappelPrise)!) != DateHelper.truncateToHour(from: (previous?.rappelPrise)!) {
                    nbCells += 1
                }
            }
        }
        print(nbCells.description + " cellules à créer")
        return nbCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pillsTableView.dequeueReusableCell(withReuseIdentifier: "MedicationCell", for: indexPath) as! MedicationCollectionViewCell
        cell.MedicamentLabel.text = medications?.get(indexPath.row)?.med.nom
        return cell
    }
    
    @IBAction func unwindFromAddPrise(segue: UIStoryboardSegue) {
        print("Prise ajoutée")
    }

}
