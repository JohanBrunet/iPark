//
//  DateHelper.swift
//  iPark
//
//  Created by Johan BRUNET on 31/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation

class DateHelper {
    
    static func formatDate(date: Date, pattern: String) -> String {
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.locale = Locale(identifier: "fr_FR")
        
        // Apply date format
        dateFormatter.dateFormat = pattern
        return dateFormatter.string(from: date)
    }
    
    static func getRappelString(rdv: Date, rappel: Date) -> String {
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        // Set date format
        dateFormatter.locale = Locale(identifier: "fr_FR")
        let timeToSubstract = -(rappel.timeIntervalSince1970)
        let tempsPrep = rdv.addingTimeInterval(timeToSubstract)
        dateFormatter.dateFormat = "HH"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let heures = dateFormatter.string(from: tempsPrep)
        dateFormatter.dateFormat = "mm"
        let minutes = dateFormatter.string(from: tempsPrep)
        let rappelString = heures + "h" + minutes + "min"
        return rappelString
    }
    
}
