//
//  SettingsTableViewController.swift
//  MinDag
//
//  Created by Paul Philip Mitchell on 28/12/15.
//  Copyright © 2015 Universitetet i Oslo. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    // MARK: Outlets
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var weekdayTimeLabel: UILabel!
    @IBOutlet weak var weekdayTimePicker: UIDatePicker!

    @IBOutlet weak var weekendTimeLabel: UILabel!
    @IBOutlet weak var weekendTimePicker: UIDatePicker!
    
    @IBOutlet weak var mathysDayLabel: UILabel!
    @IBOutlet weak var mathysDayPicker: UIPickerView!
    @IBOutlet weak var mathysTimeLabel: UILabel!
    @IBOutlet weak var mathysTimePicker: UIDatePicker!
    
    // MARK: Variables and constants
    var weekdayTimePickerHidden = true
    var weekendTimePickerHidden = true
    var mathysDayPickerHidden = true
    var mathysTimePickerHidden = true
    let weekdays = ["Mandag", "Tirsdag", "Onsdag", "Torsdag", "Fredag", "Lørdag", "Søndag"]
    
    
    // MARK: On Value Changed
    @IBAction func notificationsChanged(sender: AnyObject) {
        // TODO: Cancel notifications
        if notificationSwitch.on { Notification.sharedInstance.setupNotificationSettings() }
        UserDefaults.setBool(notificationSwitch.on, forKey: UserDefaultKey.NotificationsEnabled)
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func weekdayTimeChanged(sender: AnyObject) {
        weekdayTimeChanged()
        UserDefaults.setObject(weekdayTimePicker.date, forKey: UserDefaultKey.WeekdayTime)
    }
    @IBAction func weekendTimeChanged(sender: AnyObject) {
        weekendTimeChanged()
        UserDefaults.setObject(weekendTimePicker.date, forKey: UserDefaultKey.WeekendTime)
    }
    @IBAction func mathysTimeChanged(sender: AnyObject) {
        mathysTimeChanged()
        UserDefaults.setObject(mathysTimePicker.date, forKey: UserDefaultKey.MathysTime)
    }
    
    
    func weekdayTimeChanged() {
        weekdayTimeLabel.text = NSDateFormatter.localizedStringFromDate(
            weekdayTimePicker.date,
            dateStyle: NSDateFormatterStyle.NoStyle,
            timeStyle: NSDateFormatterStyle.ShortStyle
        )
    }
    
    func weekendTimeChanged() {
        weekendTimeLabel.text = NSDateFormatter.localizedStringFromDate(
            weekendTimePicker.date,
            dateStyle: NSDateFormatterStyle.NoStyle,
            timeStyle: NSDateFormatterStyle.ShortStyle
        )
    }
    
    func mathysTimeChanged() {
        mathysTimeLabel.text = NSDateFormatter.localizedStringFromDate(
            mathysTimePicker.date,
            dateStyle: NSDateFormatterStyle.NoStyle,
            timeStyle: NSDateFormatterStyle.ShortStyle
        )
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if      indexPath.section == 0 && indexPath.row == 1 { toggleDatepicker(1) } // WeekdayTimePicker
        else if indexPath.section == 0 && indexPath.row == 3 { toggleDatepicker(2) } // WeekendTimePicker
        else if indexPath.section == 1 && indexPath.row == 0 { toggleDatepicker(3) } // MathysDayPicker
        else if indexPath.section == 1 && indexPath.row == 2 { toggleDatepicker(4) } // MathysTimePicker
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        // Hide / Show datepickers
        if  (weekdayTimePickerHidden && indexPath.section == 0 && indexPath.row == 2) ||
            (weekendTimePickerHidden && indexPath.section == 0 && indexPath.row == 4) ||
            (mathysDayPickerHidden && indexPath.section == 1 && indexPath.row == 1) ||
            (mathysTimePickerHidden && indexPath.section == 1 && indexPath.row == 3)
        {
            return 0
        }
        
        // Hide / Show all rows in first section based on notification switch
        else if (!notificationSwitch.on && indexPath.section == 0 && indexPath.row == 1) ||
                (!notificationSwitch.on && indexPath.section == 0 && indexPath.row == 2) ||
                (!notificationSwitch.on && indexPath.section == 0 && indexPath.row == 3) ||
                (!notificationSwitch.on && indexPath.section == 0 && indexPath.row == 4)
        {
            return 0
        }
        
        else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    func toggleDatepicker(cell: Int) {
        if      cell == 1 { weekdayTimePickerHidden = !weekdayTimePickerHidden }
        else if cell == 2 { weekendTimePickerHidden =  !weekendTimePickerHidden }
        else if cell == 3 { mathysDayPickerHidden = !mathysDayPickerHidden }
        else if cell == 4 {
            mathysTimePickerHidden = !mathysTimePickerHidden
            scheduleLocalNotification()
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    // MARK: - Delegates and data sources
    // MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weekdays.count
    }
    
    // MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weekdays[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mathysDayLabel.text = weekdays[row]
        UserDefaults.setObject(weekdays[row], forKey: UserDefaultKey.MathysDay)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mathysDayPicker.dataSource = self
        mathysDayPicker.delegate = self
        
        notificationSwitch.on = UserDefaults.boolForKey(UserDefaultKey.NotificationsEnabled)
        
        if let weekdayTime = UserDefaults.objectForKey(UserDefaultKey.WeekdayTime) {
            weekdayTimePicker.setDate(
                weekdayTime as! NSDate,
                animated: true
            )
        }
        
        if let weekendTime = UserDefaults.objectForKey(UserDefaultKey.WeekendTime) {
            weekendTimePicker.setDate(
                weekendTime as! NSDate,
                animated: true
            )
        }
        
        if let mathysDay = UserDefaults.objectForKey(UserDefaultKey.MathysDay) {
            mathysDayLabel.text = mathysDay as? String
        }
        
        if let mathysTime = UserDefaults.objectForKey(UserDefaultKey.MathysTime) {
            mathysTimePicker.setDate(
                mathysTime as! NSDate,
                animated: true
            )
        }
        
        weekdayTimeChanged()
        weekendTimeChanged()
        mathysTimeChanged()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scheduleLocalNotification() {
        let localNotification = UILocalNotification()
        let fireDate = fixNotificationDate(weekdayTimePicker.date)
        localNotification.fireDate = fireDate
        localNotification.alertBody = "Du har en ny oppgave å gjøre."
        localNotification.alertAction = "Vise valg"
        localNotification.category = "NOTIFICATION_CATEGORY"
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        print("Scheduled local notification at firedate: \(fireDate)")
    }
    
    private func fixNotificationDate(dateToFix: NSDate) -> NSDate {
        
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
