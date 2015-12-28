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
    var textViewText: String!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: self.imageFile)
        titleLabel.text = titleIndex
        textView.text = textViewText
        // Do any additional setup after loading the view.
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
