//
//  PriseSet.swift
//  iPark
//
//  Created by Johan BRUNET on 02/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation

class PriseSet {
    
    fileprivate var priseSet: [Prise] = []
    let priseDAO: PriseDAO = CoreDataDAOFactory.getInstance().getPriseDAO()
    
    var count: Int {
        return self.priseSet.count
    }
    
    init(from prises: [Prise]?) {
        if let prs = prises {
            for p in prs {
                self.priseSet.append(p)
            }
        }
    }
    
    @discardableResult
    func add(_ prise: Prise) -> PriseSet {
        if !self.contains(prise) {
            self.priseSet.append(prise)
            self.priseDAO.add(prise)
        }
        return self
    }
    
    @discardableResult
    func remove(_ prise: Prise) -> PriseSet {
        if self.contains(prise) {
            self.priseSet.remove(at: self.priseSet.index(of: prise)!)
            self.priseDAO.delete(for: prise)
        }
        return self
    }
    
    func get(_ i: Int) -> Prise? {
        if(i < 0 || i >= priseSet.count) {
            return nil
        }
        return self.priseSet[i]
    }
    
    func contains(_ prise: Prise) -> Bool {
        return self.priseSet.contains(where: {$0==prise})
    }
    
    func getTodaysPrises() -> PriseSet {
        return PriseSet(from: self.priseSet.filter { DateHelper.truncateToDay(from: $0.rappelPrise) == DateHelper.truncateToDay(from: Date()) })
    }
    
    func filterByDate(forDate date: Date) -> PriseSet {
        return PriseSet(from: self.priseSet.filter { DateHelper.truncateToDay(from: $0.rappelPrise) == DateHelper.truncateToDay(from: date) })
    }
    
    func sortByDate() {
        return self.priseSet.sort(by: { (p1, p2) -> Bool in
            p1.rappelPrise <= p2.rappelPrise
        })
    }
    
}
