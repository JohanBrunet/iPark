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
    
    static func getDates(dateD: Date, dateF: Date) -> [Date] {
        var dates: [Date] = []
        var dayCount = 0
        repeat {
            days.day = dayCount
            var date: Date = cal.date(byAdding : days as DateComponents, to: dateD)!
            date = DateHelper.removeSeconds(from: date)
            dayCount += 1
            dates.append(date)
        } while truncateToDay(from: dates[dates.count - 1]) < truncateToDay(from: dateF)
        return dates
    }
    
    static func changeHour(date: Date, heureMin: Date) -> Date {
        var component1 = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        var component2 = cal.dateComponents([.hour, .minute, .second], from: heureMin)
        component1.hour = component2.hour
        component1.minute = component2.minute
        component1.second = component2.second
        let date = cal.date(from: component1)!
        return date
    }
    
    static func truncateToDay(from date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components)!
    }
    
    static func truncateToHour(from date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        return calendar.date(from: components)!
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
