//
//  WelcomeViewController.swift
//  Mathys
//
//  Created by ingeborg ødegård oftedal on 15/12/15.
//  Copyright © 2015 ingeborg ødegård oftedal. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var morningTimePicker: UIDatePicker!
    @IBOutlet weak var bedTimePicker: UIDatePicker!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueShowTaskList" {
            let morningTime = morningTimePicker.date
            let bedTime = bedTimePicker.date
            defaults.setObject(morningTime, forKey: UserDefaultKey.morningTime)
            defaults.setObject(bedTime, forKey: UserDefaultKey.bedTime)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

