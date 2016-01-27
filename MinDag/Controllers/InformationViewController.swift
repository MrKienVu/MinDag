//
//  InformationViewController.swift
//  MinDag
//
//  Created by Paul Philip Mitchell on 22/12/15.
//  Copyright © 2015 Universitetet i Oslo. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    let pageTitles = [
        "MINDAG_TITLE".localized,
        "DATA_TITLE".localized,
        "PRIVACY_TITLE".localized,
        "NOTIFICATIONS_TITLE".localized
    ]
    let pageImages = ["mindag-logo", "mindag-security", "mindag-privacy", "mindag-notification"]
    let pageTexts = [
        "MINDAG_TEXT".localized,
        "DATA_TEXT".localized,
        "PRIVACY_TEXT".localized,
        "NOTIFICATIONS_TEXT".localized
    ]

    @IBOutlet weak var configureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageControl()
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("InformationPageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(0) as InformationPageContentViewController
        let viewControllers = NSArray(object: startVC) as! [InformationPageContentViewController]
        
        self.pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRect(x: 0, y: 30, width: self.view.frame.width, height: self.view.frame.size.height - 80)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)

        // Do any additional setup after loading the view.
    }
    
    func viewControllerAtIndex(index: Int) -> InformationPageContentViewController {
        if (self.pageTitles.count == 0) || (index >= self.pageTitles.count) {
            return InformationPageContentViewController()
        }
        
        let vc: InformationPageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("InformationPageContentViewController") as! InformationPageContentViewController
        
        vc.imageFile = self.pageImages[index]
        vc.titleIndex = self.pageTitles[index]
        vc.textLabelText = self.pageTexts[index]
        vc.pageIndex = index
        
        return vc
    }
    
    // MARK: PageViewController Data Source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! InformationPageContentViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! InformationPageContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound) {
            return nil
        }
        
        index++
        if (index == self.pageTitles.count) {
            configureButton.enabled = true
            vc.permissionButton.enabled = true
            vc.permissionButton.hidden = false
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    @IBAction func configureClicked(sender: AnyObject) {
        if Notification.sharedInstance.isNotificationsEnabled() {
            UserDefaults.setBool(true, forKey: UserDefaultKey.NotificationsEnabled)
        }
    }
    
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.lightGrayColor()
        appearance.currentPageIndicatorTintColor = UIColor.blackColor()
        appearance.backgroundColor = UIColor.clearColor()
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
