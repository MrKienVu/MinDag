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
    var pageTitles: NSArray!
    var pageImages: NSArray!
    var pageTexts: NSArray!

    @IBOutlet weak var configureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageControl()
        
        pageTitles = NSArray(objects: "   ", "Datalagring", "Personvern")
        pageImages = NSArray(objects: "mindag-logo", "security", "privacy")
        pageTexts = NSArray(objects:
            "Velkommen til Min Dag! Dette forskningsprosjektet er i regi av NORMENT-senteret ved fakultetet for medisin, Universitetet i Oslo. På de neste sidene vil du kunne lese litt mer om hvordan vi håndterer datalagring osv..",
            "All data du genererer vil bli lagret på Universitetet i Oslo sine sikre servere, og ingen andre enn forskere tilkoblet dette prosjektetet vil ha tilgang til dataene. Ingen data vil bli lagret lokalt på din enhet.",
            "For å ivareta ditt personvern, vil vi ikke samle inn noe informasjon som kan identifisere deg som person. Dette er viktig fordi blabla."
        )
        
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
        
        vc.imageFile = self.pageImages[index] as! String
        vc.titleIndex = self.pageTitles[index] as! String
        vc.textViewText = self.pageTexts[index] as! String
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
