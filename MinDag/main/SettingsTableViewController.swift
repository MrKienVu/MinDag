//
//  SettingsTableViewController.swift
//  MinDag
//
//  Created by Paul Philip Mitchell on 28/12/15.
//  Copyright © 2015 Universitetet i Oslo. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, MFMailComposeViewControllerDelegate {

    
    // MARK: Outlets
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var weekdayTimeLabel: UILabel!
    @IBOutlet weak var weekdayTimePicker: UIDatePicker!

    @IBOutlet weak var weekendTimeLabel: UILabel!
    @IBOutlet weak var weekendTimePicker: UIDatePicker!
    
    
    // MARK: Variables and constants
    var weekdayTimePickerHidden = true
    var weekendTimePickerHidden = true
    
    @IBOutlet weak var contactUsCell: UITableViewCell!
    
    // MARK: On Value Changed
    @IBAction func notificationsChanged(sender: AnyObject) {
        // TODO: Cancel notifications
        if notificationSwitch.on {
            Notification.sharedInstance.setupNotificationSettings()
            scheduleNotifications()
        } else {
            Notification.sharedInstance.cancelAllNotifications()
        }
        UserDefaults.setBool(notificationSwitch.on, forKey: UserDefaultKey.NotificationsEnabled)
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func weekdayTimeChanged(sender: AnyObject) {
        weekdayTimeChanged()
        UserDefaults.setObject(weekdayTimePicker.date, forKey: UserDefaultKey.WeekdayTime)
        scheduleNotifications()
    }
    @IBAction func weekendTimeChanged(sender: AnyObject) {
        weekendTimeChanged()
        UserDefaults.setObject(weekendTimePicker.date, forKey: UserDefaultKey.WeekendTime)
        scheduleNotifications()
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
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if      indexPath.section == 1 && indexPath.row == 0 { toggleDatepicker(1) } // WeekdayTimePicker
        else if indexPath.section == 1 && indexPath.row == 2 { toggleDatepicker(2) } // WeekendTimePicker
        else if indexPath.section == 2 {
            sendEmail()
            
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        // Hide / Show datepickers
        if  (weekdayTimePickerHidden && indexPath.section == 1 && indexPath.row == 1) ||
            (weekendTimePickerHidden && indexPath.section == 1 && indexPath.row == 3)
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
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    // MARK: - Delegates and data sources
    // MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Days.count
    }
    
    // MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Days[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        scheduleNotifications()
    }
    
    func sendEmail() {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["t.v.lagerberg@medisin.uio.no"])
            mail.setSubject("MinDag")
            
            presentViewController(mail, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "MAIL_FAILED_TITLE".localized, message: "MAIL_FAILED_TEXT".localized, preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationSwitch.on = UserDefaults.boolForKey(UserDefaultKey.NotificationsEnabled)
        
        if let weekdayTime = UserDefaults.objectForKey(UserDefaultKey.WeekdayTime) {
            weekdayTimePicker.setDate(weekdayTime as! NSDate, animated: true)
        }
        
        if let weekendTime = UserDefaults.objectForKey(UserDefaultKey.WeekendTime) {
            weekendTimePicker.setDate(weekendTime as! NSDate, animated: true)
        }
        
        weekdayTimeChanged()
        weekendTimeChanged()        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scheduleNotifications() {
        Notification.sharedInstance.scheduleNotifications(
            weekdayTimePicker.date,
            weekendTime: weekendTimePicker.date
        )
    }
    
}









