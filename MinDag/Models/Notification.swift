//
//  Notification.swift
//  MinDag
//
//  Created by Paul Philip Mitchell on 30/12/15.
//  Copyright © 2015 Universitetet i Oslo. All rights reserved.
//

import Foundation
import UIKit

class Notification {
    static let sharedInstance = Notification()
    
    func isNotificationsEnabled() -> Bool {
        let currentNotificationSettings = UIApplication.sharedApplication().currentUserNotificationSettings()
        
        if currentNotificationSettings?.types == UIUserNotificationType.None {
            return false
        }
        
        return true
    }
    
    func setupNotificationSettings() {
        if !isNotificationsEnabled() {
            let notificationTypes: UIUserNotificationType = [.Alert, .Badge, .Sound]
            
            
            // Specify notification actions
            let goAction = UIMutableUserNotificationAction()
            goAction.identifier = "GO_ACTION"
            goAction.title = "Gå til app"
            goAction.activationMode = UIUserNotificationActivationMode.Foreground
            goAction.destructive = false
            goAction.authenticationRequired = true
            
            let snoozeAction = UIMutableUserNotificationAction()
            snoozeAction.identifier = "SNOOZE_ACTION"
            snoozeAction.title = "Slumre 30 min"
            snoozeAction.activationMode = UIUserNotificationActivationMode.Background
            snoozeAction.destructive = false
            snoozeAction.authenticationRequired = false
            
            let actionsArray = NSArray(objects: goAction, snoozeAction) as! [UIUserNotificationAction]
            
            // Specify the category related to the above actions
            let category = UIMutableUserNotificationCategory()
            category.identifier = "NOTIFICATION_CATEGORY"
            category.setActions(actionsArray, forContext: UIUserNotificationActionContext.Minimal)
            
            let categoriesForSettings = NSSet(objects: category)
            let notificationSettings = UIUserNotificationSettings(
                forTypes: notificationTypes,
                categories: categoriesForSettings as? Set<UIUserNotificationCategory>
            )
            
            UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        }
    }
    
    func cancelAllNotifications() {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    func scheduleNotifications(weekdayTime: NSDate, weekendTime: NSDate, weeklyDay: Int, weeklyTime: NSDate) {
        // If notifications are not enabled, do nothing
        if !UserDefaults.boolForKey(UserDefaultKey.NotificationsEnabled) { return }
        
        if !isNotificationsEnabled() {
            print("Notification switch on, but notifications not enabled. Not scheduling notifications.")
            return
        }
        
        // Else, first cancel all previous local notifications
        cancelAllNotifications()
        
        // Schedule weekday notifications
        let weekdays = createWeekdays(weekdayTime)
        for date in weekdays {
            let localNotification = UILocalNotification()
            localNotification.fireDate = date
            localNotification.alertBody = "Du har en ny oppgave å gjøre."
            localNotification.category = "NOTIFICATION_CATEGORY"
            localNotification.repeatInterval = NSCalendarUnit.WeekOfYear
            localNotification.applicationIconBadgeNumber += 1
            localNotification.userInfo = ["type": "dailySurvey"]
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            NSLog("Scheduled weekday notifications: \n \(localNotification)")
        }
        
        // Schedule weekend notifications
        let weekends = createWeekends(weekendTime)
        for date in weekends {
            let localNotification = UILocalNotification()
            localNotification.fireDate = date
            localNotification.alertBody = "Du har en ny oppgave å gjøre."
            localNotification.category = "NOTIFICATION_CATEGORY"
            localNotification.repeatInterval = NSCalendarUnit.WeekOfYear
            localNotification.applicationIconBadgeNumber += 1
            localNotification.userInfo = ["type": "dailySurvey"]
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            NSLog("Scheduled weekend notifications: \n \(localNotification)")
        }
        
        // Schedule weekly notifications
        let weeklyDate = createWeeklyDate(weeklyTime, day: weeklyDay)
        let localNotification = UILocalNotification()
        localNotification.fireDate = weeklyDate
        localNotification.alertBody = "Du har en ny oppgave å gjøre."
        localNotification.category = "NOTIFICATION_CATEGORY"
        localNotification.repeatInterval = NSCalendarUnit.WeekOfYear
        localNotification.applicationIconBadgeNumber += 1
        localNotification.userInfo = ["type": "weeklySurvey"]
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        NSLog("Scheduled weekly notifications: \n \(localNotification)")
    }
    
    func createWeeklyDate(time: NSDate, day: Int) -> NSDate {
        let dateHourMinute = NSCalendar.currentCalendar().components([.Hour, .Minute], fromDate: time)
        dateHourMinute.day = day
        dateHourMinute.month = 2
        dateHourMinute.year = 2016
        return NSCalendar.currentCalendar().dateFromComponents(dateHourMinute)!
    }
    
    func createWeekdays(time: NSDate) -> [NSDate] {
        var weekdays: [NSDate] = []
        let dateHourMinute = NSCalendar.currentCalendar().components([.Hour, .Minute], fromDate: time)
        for i in 1...5 {
            dateHourMinute.day = i
            dateHourMinute.month = 2
            dateHourMinute.year = 2016
            weekdays.append(NSCalendar.currentCalendar().dateFromComponents(dateHourMinute)!)
        }
        return weekdays
        
    }
    
    func createWeekends(time: NSDate) -> [NSDate] {
        var weekends: [NSDate] = []
        let dateHourMinute = NSCalendar.currentCalendar().components([.Hour, .Minute], fromDate: time)
        for i in 6...7 {
            dateHourMinute.day = i
            dateHourMinute.month = 2
            dateHourMinute.year = 2016
            weekends.append(NSCalendar.currentCalendar().dateFromComponents(dateHourMinute)!)
        }
        return weekends
    }
    
    func createDefaultDates() -> [NSDate] {
        let calendar = NSCalendar.currentCalendar()
        let today = NSDate()
        
        let weekday = calendar.dateBySettingHour(8, minute: 0, second: 0, ofDate: today, options: NSCalendarOptions())!
        let weekend = calendar.dateBySettingHour(9, minute: 0, second: 0, ofDate: today, options: NSCalendarOptions())!
        let weekly = calendar.dateBySettingHour(18, minute: 0, second: 0, ofDate: today, options: NSCalendarOptions())!
        
        return [weekday, weekend, weekly]
    }
}
