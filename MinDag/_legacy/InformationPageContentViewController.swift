//
//  InformationPageContentViewController.swift
//  MinDag
//
//  Created by Paul Philip Mitchell on 22/12/15.
//  Copyright © 2015 Universitetet i Oslo. All rights reserved.
//

import UIKit

class InformationPageContentViewController: UIViewController {
    
    var pageIndex: Int!
    var titleIndex: String!
    var imageFile: String!
    var textLabelText: String!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var permissionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: self.imageFile)
        titleLabel.text = titleIndex
        textLabel.text = textLabelText
    }
    
    override func viewDidLayoutSubviews() {
        configureButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func permissionsClicked(sender: AnyObject) {
        Notification.sharedInstance.setupNotificationSettings()
    }
    
    func configureButton()
    {
        permissionButton.layer.cornerRadius = 5
        permissionButton.layer.borderColor = Color.primaryColor.CGColor
        permissionButton.layer.borderWidth = 1
        permissionButton.clipsToBounds = true
    }


}
