//
//  NotificationsViewController.swift
//  MinDag
//
//  Created by Paul Philip Mitchell on 19/02/16.
//  Copyright © 2016 Universitetet i Oslo. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {

    @IBOutlet weak var givePermissionButton: UIButton!
    @IBOutlet weak var notNowButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func givePermissionClicked(sender: AnyObject) {
        Notification.sharedInstance.setupNotificationSettings()
        
        UIView.animateWithDuration(0.8, animations: {
            self.nextButton.alpha = 1
            self.notNowButton.alpha = 0
            self.givePermissionButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0), forState: .Normal)
        })
        
        nextButton.enabled = true
        nextButton.hidden = false
        notNowButton.enabled = false
        notNowButton.hidden = true
        givePermissionButton.enabled = false
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if Notification.sharedInstance.isNotificationsEnabled() {
            UserDefaults.setBool(true, forKey: UserDefaultKey.NotificationsEnabled)
        }
    }

}