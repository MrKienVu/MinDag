//
//  NoInternetConnectionView.swift
//  MinDag
//
//  Created by ingeborg ødegård oftedal on 10/05/16.
//  Copyright © 2016 Universitetet i Oslo. All rights reserved.
//

import Foundation
import UIKit

class NoInternetConnectionView : UIAlertView {
    var label: UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: CGRectMake(0, 0, 350, 400))
        addCustomView()
    }
    func addCustomView(){
        label.frame = CGRectMake(50,10,200,100)
        label.backgroundColor=UIColor.blackColor()
        label.text = "yolo"
        self.addSubview(label)
    }
}
