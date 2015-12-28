//
//  Constants.swift
//  Mathys
//
//  Created by ingeborg ødegård oftedal on 15/12/15.
//  Copyright © 2015 ingeborg ødegård oftedal. All rights reserved.
//

import Foundation
import UIKit

let USERDEFAULTS = NSUserDefaults.standardUserDefaults()

struct Color {
    static let primaryColor = UIColor(red: 0.22, green: 0.58, blue: 0.29, alpha: 1.0)
    static let secondaryColor = UIColor.lightGrayColor()
}

struct UserDefaultKey {
    static let WeekdayTime = "WeekdayTime"
    static let WeekendTime = "WeekendTime"
    static let MathysTime = "MathysTime"
    static let MathysDay = "MathysDay"
    static let hasLaunchedBefore = "HasLaunchedBefore"
    static let UUID = "UUID"
}