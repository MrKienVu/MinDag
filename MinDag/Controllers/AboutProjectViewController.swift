//
//  AboutProjectViewController.swift
//  MinDag
//
//  Created by Paul Philip Mitchell on 27/01/16.
//  Copyright © 2016 Universitetet i Oslo. All rights reserved.
//

import UIKit

class AboutProjectViewController: UIViewController {

    @IBOutlet weak var MinDagTitle: UILabel!
    @IBOutlet weak var MinDagText: UILabel!
    @IBOutlet weak var DataTitle: UILabel!
    @IBOutlet weak var DataText: UILabel!
    @IBOutlet weak var PrivacyTitle: UILabel!
    @IBOutlet weak var PrivacyText: UILabel!
    @IBOutlet weak var NotificationsTitle: UILabel!
    @IBOutlet weak var NotificationsText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MinDagTitle.text        = "MINDAG_TITLE".localized
        MinDagText.text         = "MINDAG_TEXT".localized
        DataTitle.text          = "DATA_TITLE".localized
        DataText.text           = "DATA_TEXT".localized
        PrivacyTitle.text       = "PRIVACY_TITLE".localized
        PrivacyText.text        = "PRIVACY_TEXT".localized
        NotificationsTitle.text = "NOTIFICATIONS_TITLE".localized
        NotificationsText.text  = "NOTIFICATIONS_TEXT".localized

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        
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
