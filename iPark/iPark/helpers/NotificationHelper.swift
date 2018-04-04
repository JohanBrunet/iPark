//
//  NotificationHelper.swift
//  iPark
//
//  Created by Johan BRUNET on 31/03/2018.
//  Copyright © 2018 Kévin GIORDANI. All rights reserved.
//

import UIKit
import UserNotifications

class MyNotificationCenter {
    
    let myNotification = Notification.Name(rawValue:"MyNotification")
    let content = UNMutableNotificationContent()
    
    init(){
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "UYLDeleteAction", title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: "UYLReminderCategory",
                                              actions: [snoozeAction,deleteAction],
                                              intentIdentifiers: [], options: [])
        AppDelegate.center.setNotificationCategories([category])
    }
    
    func addNotification(identifier:String, title:String,body:String,date:Date, repeatable: Bool) {
        if date > Date() {
            content.title = title
            content.body = body
            content.sound = UNNotificationSound.default()
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: date.timeIntervalSince(Date()), repeats: repeatable)
            let identifier = identifier
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            AppDelegate.center.add(request, withCompletionHandler: { (error) in
                if let error = error {
                    print(error)
                }
            })
            print("Notification ajoutée !")
        }
    }
    
    func removeNotification(identifier:[String]){
        AppDelegate.center.removePendingNotificationRequests(withIdentifiers: identifier)
        print("Notification supprimée !")
    }
    
}
