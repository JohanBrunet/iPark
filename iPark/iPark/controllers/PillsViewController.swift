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
        self.medications = PriseSet(from: CoreDataDAOFactory.getInstance().getPriseDAO().getAll()!).getTodaysPrises()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var nbCells: Int = 0
        print((self.medications?.count.description)! + " prises aujourd'hui")
        if self.medications?.count != 0 {
            for i in 0...((self.medications?.count)! - 1) {
                let previous = (i > 0) ? self.medications?.get(i - 1) : self.medications?.get(i)
                let datePrevious = DateHelper.truncateToHour(from: (previous?.rappelPrise)!)
                let dateCurrent = DateHelper.truncateToHour(from: (self.medications?.get(i)?.rappelPrise)!)
                print("\n Previous")
                print(datePrevious)
                print("\n Current")
                print(dateCurrent)
                if dateCurrent != datePrevious {
                    nbCells += 1
                }
            }
        }
        print(nbCells.description + " cellules à créer")
        return nbCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pillsTableView.dequeueReusableCell(withReuseIdentifier: "MedicationCell", for: indexPath) as! MedicationCollectionViewCell
        let prise = self.medications?.get(indexPath.row)
        cell.DosageLabel.text = prise?.doseMed
        cell.MedicamentLabel.text = prise?.med.nom
        let heurePrise = DateHelper.formatDate(date: (prise?.rappelPrise)!, pattern: "HH")
        cell.HourLabel.text = heurePrise
        return cell
    }
    
    @IBAction func unwindFromAddPrise(segue: UIStoryboardSegue) {
        self.medications = PriseSet(from: CoreDataDAOFactory.getInstance().getPriseDAO().getAll()!).getTodaysPrises()
        self.pillsTableView.reloadData()
    }

}
