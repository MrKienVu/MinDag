//
//  Constants.swift
//  Mathys
//
//  Created by ingeborg ødegård oftedal on 15/12/15.
//  Copyright © 2015 ingeborg ødegård oftedal. All rights reserved.
//

import Foundation
import UIKit

let UserDefaults = NSUserDefaults.standardUserDefaults()

struct Color {
    static let primaryColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
    static let secondaryColor = UIColor.lightGrayColor()
}

struct UserDefaultKey {
    static let WeekdayTime = "WeekdayTime"
    static let WeekendTime = "WeekendTime"
    static let MathysTime = "MathysTime"
    static let MathysDay = "MathysDay"
    static let hasLaunchedBefore = "HasLaunchedBefore"
    static let UUID = "UUID"
    static let NotificationsEnabled = "NotificationsEnabled"
}