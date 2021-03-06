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
    @IBOutlet weak var checkmarkLabel: UILabel!
    @IBOutlet weak var notificationsEnabledLabel: UILabel!
    @IBOutlet weak var notificationsText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        if Notification.sharedInstance.isNotificationsEnabled() {
            enableNextButton()
            showEnabledLabels()
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NotificationsViewController.animateEnabledLabels), name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationDidBecomeActiveNotification, object: nil)
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
        
        enableNextButton()
    }
    
    func animateEnabledLabels() {
        UIView.animateWithDuration(0.8, animations: {
            self.showEnabledLabels()
        })
    }
    
    func showEnabledLabels() {
        checkmarkLabel.alpha = 1
        notificationsEnabledLabel.alpha = 1
    }
    
    func enableNextButton() {
        // Show next button
        nextButton.enabled = true
        nextButton.alpha = 1
        nextButton.hidden = false
        
        // Hide 'Not Now'-button and 'Give Permissions'-button
        notNowButton.enabled = false
        notNowButton.hidden = true
        
        givePermissionButton.enabled = false
        givePermissionButton.hidden = true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if Notification.sharedInstance.isNotificationsEnabled() {
            UserDefaults.setBool(true, forKey: UserDefaultKey.NotificationsEnabled)
        }
        let defaultDates = Notification.sharedInstance.getDefaultDates()
        Notification.sharedInstance.scheduleNotifications(defaultDates[0], weekendTime: defaultDates[1])
    }

}
