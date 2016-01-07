//
//  SetUpViewController.swift
//  MinDag
//
//  Created by ingeborg ødegård oftedal on 05/01/16.
//  Copyright © 2016 Universitetet i Oslo. All rights reserved.
//

import Foundation
import UIKit


class SetUpViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var weekdayTimeLabel: UILabel!
    @IBOutlet weak var weekdayTimePicker: UIDatePicker!
    @IBOutlet weak var weekendTimeLabel: UILabel!
    @IBOutlet weak var weekendTimePicker: UIDatePicker!
    
    @IBOutlet weak var mathysDayLabel: UILabel!
    @IBOutlet weak var mathysDayPicker: UIPickerView!
    @IBOutlet weak var mathysTimeLabel: UILabel!
    @IBOutlet weak var mathysTimePicker: UIDatePicker!
        
    @IBOutlet weak var studyIdTextField: UITextField!
    
    // MARK: Variables and constants
    var weekdayTimePickerHidden = true
    var weekendTimePickerHidden = true
    var mathysDayPickerHidden = true
    var mathysTimePickerHidden = true
    
    
    // MARK: On Value Changed
    @IBAction func notificationsChanged(sender: AnyObject) {
        // TODO: Cancel notifications
        if notificationSwitch.on { Notification.sharedInstance.setupNotificationSettings() }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func weekdayTimeChanged(sender: AnyObject) {
        weekdayTimeChanged()
    }
    @IBAction func weekendTimeChanged(sender: AnyObject) {
        weekendTimeChanged()
    }
    @IBAction func mathysTimeChanged(sender: AnyObject) {
        mathysTimeChanged()
    }
    
    
    @IBAction func studyIdChanged(sender: AnyObject) {
        let text = studyIdTextField.text! as String
        if text.characters.count >= 8 {
            doneButton.enabled = true
        }
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
        else if indexPath.section == 2 && indexPath.row == 0 { studyIdTextField.becomeFirstResponder() }
        
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
        else if (!notificationSwitch.on && indexPath.section == 0 &&
                (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4))
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
        else if cell == 4 { mathysTimePickerHidden = !mathysTimePickerHidden }
        
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
        mathysDayLabel.text = Days[row]
        UserDefaults.setInteger(row, forKey: UserDefaultKey.MathysDay)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mathysDayPicker.dataSource = self
        mathysDayPicker.delegate = self
        studyIdTextField.delegate = self
        
        if let weekdayTime = UserDefaults.objectForKey(UserDefaultKey.WeekdayTime) {
            weekdayTimePicker.setDate(weekdayTime as! NSDate, animated: true)
        }
        
        if let weekendTime = UserDefaults.objectForKey(UserDefaultKey.WeekendTime) {
            weekendTimePicker.setDate(weekendTime as! NSDate, animated: true)
        }
        
        let mathysDay = UserDefaults.integerForKey(UserDefaultKey.MathysDay)
        mathysDayLabel.text = Days[mathysDay]
        
        mathysDayPicker.selectRow(mathysDay, inComponent: 0, animated: true)
        
        if let mathysTime = UserDefaults.objectForKey(UserDefaultKey.MathysTime) {
            mathysTimePicker.setDate(mathysTime as! NSDate, animated: true)
        }
        
        weekdayTimeChanged()
        weekendTimeChanged()
        mathysTimeChanged()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        UserDefaults.setBool(notificationSwitch.on, forKey: UserDefaultKey.NotificationsEnabled)
        UserDefaults.setObject(weekdayTimePicker.date, forKey: UserDefaultKey.WeekdayTime)
        UserDefaults.setObject(weekendTimePicker.date, forKey: UserDefaultKey.WeekendTime)
        UserDefaults.setObject(studyIdTextField.text!, forKey: UserDefaultKey.StudyID)    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
