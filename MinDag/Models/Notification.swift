//
//  Notification.swift
//  MinDag
//
//  Created by Paul Philip Mitchell on 30/12/15.
//  Copyright © 2015 Universitetet i Oslo. All rights reserved.
//

import Foundation

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
    
    func createWeeklyDate(dateToModify: NSDate, weekday: Int) -> NSDate {
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
    }
    
    func DEMO_scheduleLocalNotification(date: NSDate) {
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
