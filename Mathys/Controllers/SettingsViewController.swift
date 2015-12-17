//
//  SettingsViewController.swift
//  Mathys
//
//  Created by Paul Philip Mitchell on 15/12/15.
//  Copyright © 2015 ingeborg ødegård oftedal. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var mathysTimePicker: UIDatePicker!
    @IBOutlet weak var bedTimePicker: UIDatePicker!
    @IBOutlet weak var morningTimePicker: UIDatePicker!
    
    @IBOutlet weak var userIdLabel: UILabel!
    @IBAction func morningTimeChanged(sender: AnyObject) {
        USERDEFAULTS.setObject(
            morningTimePicker.date,
            forKey: UserDefaultKey.morningTime
        )
    }
    
    @IBAction func bedTimeChanged(sender: AnyObject) {
        USERDEFAULTS.setObject(
            bedTimePicker.date,
            forKey: UserDefaultKey.bedTime
        )
    }
    
    @IBAction func mathysTimeChanged(sender: AnyObject) {
        USERDEFAULTS.setObject(
            mathysTimePicker.date,
            forKey: UserDefaultKey.mathysTime
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        morningTimePicker.setDate(
            USERDEFAULTS.objectForKey(UserDefaultKey.morningTime) as! NSDate,
            animated: true
        )
        
        bedTimePicker.setDate(
            USERDEFAULTS.objectForKey(UserDefaultKey.bedTime) as! NSDate,
            animated: true
        )
        
        if let mathysTime = USERDEFAULTS.objectForKey(UserDefaultKey.mathysTime) {
            mathysTimePicker.setDate(
                mathysTime as! NSDate,
                animated: true
            )
        }
        
        userIdLabel.text! += USERDEFAULTS.objectForKey(UserDefaultKey.UUID) as! String

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
