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
    static let primaryColor = UIColor(red: 1, green: 0.6823, blue: 0.0901, alpha: 1)
    static let secondaryColor = UIColor.lightGrayColor()
}

struct UserDefaultKey {
    static let WeekdayTime = "WeekdayTime"
    static let WeekendTime = "WeekendTime"
    static let MathysTime = "MathysTime"
    static let MathysDay = "MathysDay"
    static let hasLaunchedBefore = "HasLaunchedBefore"
    static let UUID = "UUID"
    static let StudyID = "StudyID"
    static let NotificationsEnabled = "NotificationsEnabled"
    static let CompletedOnboarding = "CompletedOnboarding"
}

struct Encrypted {
    static let account = "User"
    static let studyID = "StudyID"
}

let Days: [Int: String] = [
    0: "Mandag",
    1: "Tirsdag",
    2: "Onsdag",
    3: "Torsdag",
    4: "Fredag",
    5: "Lørdag",
    6: "Søndag"
]