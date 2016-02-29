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
        if !isNotificationsEnabled() { return }
        
        // Else, first cancel all previous local notifications
        cancelAllNotifications()
        
        // Schedule weekday notifications
        let weekdays = createWeekdays(weekdayTime)
        for date in weekdays {
            let localNotification = UILocalNotification()
            localNotification.fireDate = date
            localNotification.alertBody = "Du har en ny oppgave å gjøre."
            localNotification.alertAction = "Vise valg"
            localNotification.category = "NOTIFICATION_CATEGORY"
            localNotification.repeatInterval = NSCalendarUnit.WeekOfYear
            localNotification.applicationIconBadgeNumber += 1
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        }
        
        // Schedule weekend notifications
        let weekends = createWeekends(weekendTime)
        for date in weekends {
            let localNotification = UILocalNotification()
            localNotification.fireDate = date
            localNotification.alertBody = "Du har en ny oppgave å gjøre."
            localNotification.alertAction = "Vise valg"
            localNotification.category = "NOTIFICATION_CATEGORY"
            localNotification.repeatInterval = NSCalendarUnit.WeekOfYear
            localNotification.applicationIconBadgeNumber += 1
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        }
        
        // Schedule weekly notifications
        let weeklyDate = createWeeklyDate(weeklyTime, day: weeklyDay)
        let localNotification = UILocalNotification()
        localNotification.fireDate = weeklyDate
        localNotification.alertBody = "Du har en ny oppgave å gjøre."
        localNotification.alertAction = "Vise valg"
        localNotification.category = "NOTIFICATION_CATEGORY"
        localNotification.repeatInterval = NSCalendarUnit.WeekOfYear
        localNotification.applicationIconBadgeNumber += 1
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
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
    
    func scheduleLocalNotification(date: NSDate) {
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components([.Hour, .Minute, .Second], fromDate: date)
        let currentComponents = calendar.components([.Year, .Weekday], fromDate: NSDate())
        
        for i in 2...6 {
            currentComponents.hour = dateComponents.hour
            currentComponents.minute = dateComponents.minute
            currentComponents.second = 0
            currentComponents.weekday = i
            
            let notification = UILocalNotification()
            
            notification.repeatInterval = NSCalendarUnit.Minute
            let test = calendar.dateFromComponents(currentComponents)
            print(calendar.components([.Weekday], fromDate: test!).weekday)
            notification.fireDate = calendar.dateFromComponents(currentComponents)
            notification.alertBody = "Du har en ny oppgave å gjøre."
            notification.alertAction = "Vise valg"
            notification.category = "NOTIFICATION_CATEGORY"
            
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            print("\(notification) \n\n\n\n")
            
        }
        
    }
    
    /*func createWeeklyDate(dateToModify: NSDate, weekday: Int) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        
        let currentDate = calendar.components([.Year, .Month, .Weekday], fromDate: NSDate())
        
        let currentComponents = calendar.components([.Hour, .Minute], fromDate: dateToModify)
        let fixedComponents = NSDateComponents()
        fixedComponents.year = currentDate.year
        fixedComponents.month = currentDate.month
        fixedComponents.weekday = weekday
        fixedComponents.hour = currentComponents.hour
        fixedComponents.minute = currentComponents.minute
        
        print(calendar.components([.Weekday], fromDate: NSDate()).weekday)
        
        return calendar.dateFromComponents(fixedComponents)!
    }*/
    
    func DEMO_scheduleLocalNotification(date: NSDate) {
        createWeekdays(date)
        let localNotification = UILocalNotification()
        let fireDate = DEMO_fixNotificationDate(date)
        localNotification.fireDate = fireDate
        localNotification.alertBody = "Du har en ny oppgave å gjøre."
        localNotification.alertAction = "Vise valg"
        localNotification.category = "NOTIFICATION_CATEGORY"
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        print("Scheduled local notification at firedate: \(fireDate)")
    }
    
    private func DEMO_fixNotificationDate(dateToFix: NSDate) -> NSDate {
        
        let calendar = NSCalendar.currentCalendar()
        
        let currentDate = NSDate()
        let currentDateComponents = calendar.components([.Year, .Month, .Day], fromDate: currentDate)
        
        let otherDateComponents = calendar.components([.Year, .Month, .Day, .Hour, .Minute], fromDate: dateToFix)
        otherDateComponents.year = currentDateComponents.year
        otherDateComponents.month = currentDateComponents.month
        otherDateComponents.day = currentDateComponents.day
        
        let fixedDate = calendar.dateFromComponents(otherDateComponents)
        
        return fixedDate!
    }
}
