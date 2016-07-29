import UIKit
import ResearchKit
import Fabric
import Crashlytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window?.tintColor = Color.primaryColor
        application.applicationIconBadgeNumber = 0
        
        let completedOnboarding = UserDefaults.boolForKey(UserDefaultKey.CompletedOnboarding)
        
        let onboarding = UIStoryboard(name: "Onboarding", bundle: nil)
        let main = UIStoryboard(name: "Main", bundle: nil)
        window?.rootViewController = completedOnboarding ? main.instantiateInitialViewController() : onboarding.instantiateInitialViewController()
        
        let hasLaunchedBefore = UserDefaults.boolForKey(UserDefaultKey.hasLaunchedBefore)
        if !hasLaunchedBefore  {
            let uuid = NSUUID().UUIDString
            UserDefaults.setObject(uuid, forKey: UserDefaultKey.UUID)
            print("Stored user ID \(uuid) in UserDefaults")
            
            ORKPasscodeViewController.removePasscodeFromKeychain()
            print("Removed passcode from Keychain")
            
            UserDefaults.setBool(true, forKey: UserDefaultKey.hasLaunchedBefore)
            print("HasLaunched flag enabled in UserDefaults")
        }
        lock()
        
        if let options = launchOptions,
            notification = options[UIApplicationLaunchOptionsLocalNotificationKey] as? UILocalNotification,
            userInfo = notification.userInfo
        {
            handleNotificationTap(userInfo);
        }
        Fabric.with([Crashlytics.self])
        return true
    }
    
    func handleNotificationTap(userInfo: [NSObject: AnyObject]) {
        let type = userInfo["type"] as! String
        if      type == "dailySurvey"   { NSNotificationCenter.defaultCenter().postNotificationName("dailySurvey", object: nil) }
        else if type == "weeklySurvey"  { NSNotificationCenter.defaultCenter().postNotificationName("weeklySurvey", object: nil) }
    }
    
    func lock() {
        guard ORKPasscodeViewController.isPasscodeStoredInKeychain()
            && !(window?.rootViewController?.presentedViewController is ORKPasscodeViewController)
            && UserDefaults.boolForKey(UserDefaultKey.CompletedOnboarding)
            else { return }
        
        window?.makeKeyAndVisible()
        
        let passcodeVC = ORKPasscodeViewController.passcodeAuthenticationViewControllerWithText("Velkommen tilbake til Min Dag.", delegate: self) as! ORKPasscodeViewController
        window?.rootViewController?.presentViewController(passcodeVC, animated: false, completion: nil)
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        print(notificationSettings.types.rawValue)
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        let state = application.applicationState
        if (state != UIApplicationState.Active) {
            handleNotificationTap(notification.userInfo!)
        }
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        application.applicationIconBadgeNumber = 0
        
        switch identifier {
            case "GO_ACTION"?:
                handleNotificationTap(notification.userInfo!)
            case "SNOOZE_ACTION"?:
                notification.fireDate = NSDate().dateByAddingTimeInterval(Double(60 * Notifications.snoozeDelayInMinutes))
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
            default: break
        }
        
        completionHandler()
    }
    
    func applicationWillResignActive(application: UIApplication) {
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
    }
    
    func applicationWillTerminate(application: UIApplication) {
    }
    
    
}

extension AppDelegate: ORKPasscodeDelegate {
    func passcodeViewControllerDidFinishWithSuccess(viewController: UIViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func passcodeViewControllerDidFailAuthentication(viewController: UIViewController) {
        // Todo
    }
}

