//
//  WelcomeViewController.swift
//  Mathys
//
//  Created by ingeborg ødegård oftedal on 15/12/15.
//  Copyright © 2015 ingeborg ødegård oftedal. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBAction func joinTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        let taskList = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TaskList")
        self.presentViewController(taskList, animated: true, completion: nil)
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

