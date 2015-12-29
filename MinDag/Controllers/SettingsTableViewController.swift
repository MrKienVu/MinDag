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
    @IBOutlet weak var weekdayTimeLabel: UILabel!
    @IBOutlet weak var weekdayTimePicker: UIDatePicker!

    @IBOutlet weak var weekendTimeLabel: UILabel!
    @IBOutlet weak var weekendTimePicker: UIDatePicker!
    
    @IBOutlet weak var mathysDayLabel: UILabel!
    @IBOutlet weak var mathysDayPicker: UIPickerView!
    @IBOutlet weak var mathysTimeLabel: UILabel!
    @IBOutlet weak var mathysTimePicker: UIDatePicker!
    
    @IBOutlet weak var studyIDLabel: UITextField!
    
    // MARK: Variables and constants
    var weekdayTimePickerHidden = true
    var weekendTimePickerHidden = true
    var mathysDayPickerHidden = true
    var mathysTimePickerHidden = true
    let weekdays = ["Mandag", "Tirsdag", "Onsdag", "Torsdag", "Fredag", "Lørdag", "Søndag"]
    
    
    // MARK: On Value Changed
    @IBAction func weekdayTimeChanged(sender: AnyObject) {
        weekdayTimeChanged()
        USERDEFAULTS.setObject(weekdayTimePicker.date, forKey: UserDefaultKey.WeekdayTime)
    }
    @IBAction func weekendTimeChanged(sender: AnyObject) {
        weekendTimeChanged()
        USERDEFAULTS.setObject(weekendTimePicker.date, forKey: UserDefaultKey.WeekendTime)
    }
    @IBAction func mathysTimeChanged(sender: AnyObject) {
        mathysTimeChanged()
        USERDEFAULTS.setObject(mathysTimePicker.date, forKey: UserDefaultKey.MathysTime)
    }
    @IBAction func studyIDChanged(sender: AnyObject) {
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
        if indexPath.section == 0 && indexPath.row == 0 { toggleDatepicker(1) } // WeekdayTimePicker
        else if indexPath.section == 0 && indexPath.row == 2 { toggleDatepicker(2) } // WeekendTimePicker
        else if indexPath.section == 1 && indexPath.row == 0 { toggleDatepicker(3) } // MathysDayPicker
        else if indexPath.section == 1 && indexPath.row == 2 { toggleDatepicker(4) } // MathysTimePicker
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (weekdayTimePickerHidden && indexPath.section == 0 && indexPath.row == 1) ||
            (weekendTimePickerHidden && indexPath.section == 0 && indexPath.row == 3) ||
            (mathysDayPickerHidden && indexPath.section == 1 && indexPath.row == 1) ||
            (mathysTimePickerHidden && indexPath.section == 1 && indexPath.row == 3) {
                return 0
        } else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    func toggleDatepicker(cell: Int) {
        if cell == 1 { weekdayTimePickerHidden = !weekdayTimePickerHidden }
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
        return weekdays.count
    }
    
    // MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weekdays[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mathysDayLabel.text = weekdays[row]
        USERDEFAULTS.setObject(weekdays[row], forKey: UserDefaultKey.MathysDay)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mathysDayPicker.dataSource = self
        mathysDayPicker.delegate = self
        
        if let weekdayTime = USERDEFAULTS.objectForKey(UserDefaultKey.WeekdayTime) {
            weekdayTimePicker.setDate(
                weekdayTime as! NSDate,
                animated: true
            )
        }
        
        if let weekendTime = USERDEFAULTS.objectForKey(UserDefaultKey.WeekendTime) {
            weekendTimePicker.setDate(
                weekendTime as! NSDate,
                animated: true
            )
        }
        
        if let mathysDay = USERDEFAULTS.objectForKey(UserDefaultKey.MathysDay) {
            mathysDayLabel.text = mathysDay as? String
        }
        
        if let mathysTime = USERDEFAULTS.objectForKey(UserDefaultKey.MathysTime) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
