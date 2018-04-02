//
//  DateHelper.swift
//  iPark
//
//  Created by Johan BRUNET on 31/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation

class DateHelper {
    
    static var cal = NSCalendar.current
    static var days = NSDateComponents()
    
    static func getDates(dateD: NSDate, dateF: NSDate) -> [NSDate] {
        var dates: [NSDate] = []
        var dayCount = 1
        repeat {
            days.day = dayCount
            var date:NSDate = cal.date(byAdding : days as DateComponents, to: dateD as Date)! as NSDate
            date = DateHelper.removeSeconds(from: date as Date) as NSDate
            dayCount += 1
            dates.append(date)
        } while (dates[dates.count - 1] as Date) <= (dateF as Date)
        return dates
    }
    
    static func removeSeconds(from date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        return calendar.date(from: components)!
    }
    
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
