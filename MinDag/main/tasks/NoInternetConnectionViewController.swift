//
//  NoInternetConnectionViewController.swift
//  MinDag
//
//  Created by ingeborg ødegård oftedal on 10/05/16.
//  Copyright © 2016 Universitetet i Oslo. All rights reserved.
//

import Foundation
import ResearchKit

class NoInternetConnectionViewController : ORKActiveStepViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = NoInternetConnectionView()
        showAlert()

        view.translatesAutoresizingMaskIntoConstraints = false
        self.customView = view
        self.customView?.intrinsicContentSize()
        self.customView?.superview?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[view]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": view]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[view]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": view]))
    }
    @IBAction func showAlert(){
        let alertController = UIAlertController (title: "INTERNET_UNAVAILABLE_TITLE".localized, message: "INTERNET_UNAVAILABLE_TEXT".localized, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}