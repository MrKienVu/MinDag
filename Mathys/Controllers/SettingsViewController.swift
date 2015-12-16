//
//  SettingsViewController.swift
//  Mathys
//
//  Created by Paul Philip Mitchell on 15/12/15.
//  Copyright © 2015 ingeborg ødegård oftedal. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var mathysTimePicker: UIDatePicker!
    @IBOutlet weak var bedTimePicker: UIDatePicker!
    @IBOutlet weak var morningTimePicker: UIDatePicker!
    
    @IBAction func morningTimeChanged(sender: AnyObject) {
        defaults.setObject(
            morningTimePicker.date,
            forKey: UserDefaultKey.morningTime
        )
    }
    
    @IBAction func bedTimeChanged(sender: AnyObject) {
        defaults.setObject(
            bedTimePicker.date,
            forKey: UserDefaultKey.bedTime
        )
    }
    
    @IBAction func mathysTimeChanged(sender: AnyObject) {
        defaults.setObject(
            mathysTimePicker.date,
            forKey: UserDefaultKey.mathysTime
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        morningTimePicker.setDate(
            defaults.objectForKey(UserDefaultKey.morningTime) as! NSDate,
            animated: true
        )
        
        bedTimePicker.setDate(
            defaults.objectForKey(UserDefaultKey.bedTime) as! NSDate,
            animated: true
        )

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
