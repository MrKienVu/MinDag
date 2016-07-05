import Foundation
import UIKit

let UserDefaults = NSUserDefaults.standardUserDefaults()

struct Color {
    static let primaryColor = UIColor(red: 1, green: 0.6823, blue: 0.0901, alpha: 1)
    static let secondaryColor = UIColor.lightGrayColor()
    static let disabledColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
}

struct Notifications {
    static let snoozeDelayInMinutes = 60
}

struct UserDefaultKey {
    static let WeekdayTime = "WeekdayTime"
    static let WeekendTime = "WeekendTime"
    static let hasLaunchedBefore = "HasLaunchedBefore"
    static let UUID = "UUID"
    static let StudyID = "StudyID"
    static let NotificationsEnabled = "NotificationsEnabled"
    static let CompletedOnboarding = "CompletedOnboarding"
    static let testModeEnabled = "TestModeEnabled"
    static let lastDailyFormTime = "LastDailyFormTime"
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