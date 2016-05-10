//
//  TaskListViewController.swift
//  Mathys
//
//  Created by Paul Philip Mitchell on 15/12/15.
//  Copyright © 2015 ingeborg ødegård oftedal. All rights reserved.
//

import UIKit
import ResearchKit

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ORKTaskViewControllerDelegate {
    
    let nettskjema = NettskjemaHandler(scheme: .Mathys)
    let logos = ["copier", "crescentmoon"]

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var settingsIcon: UIBarButtonItem!
    
    enum TableViewCellIdentifier: String {
        case Default = "Default"
    }
    
    // MARK: Properties
    
    /**
    When a task is completed, the `TaskListViewController` calls this closure
    with the created task.
    */
    var taskResultFinishedCompletionHandler: (ORKResult -> Void)?
    
    let taskListRows = TaskListRow.allCases

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        animateSettingsIconWithDuration(1.7)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TaskListViewController.presentDailySurvey), name: "presentDailySurvey", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TaskListViewController.presentWeeklySurvey), name: "presentWeeklySurvey", object: nil)
        
        // Register custom cell
        let nib = UINib(nibName: "TaskTableViewCellView", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Default")
    }
    
    override func viewWillAppear(animated: Bool) {
        UserDefaults.setBool(true, forKey: UserDefaultKey.CompletedOnboarding)
        print("Completed onboarding")
    }
    
    @IBAction func showAlert(){
        let alertController = UIAlertController (title: "INTERNET_UNAVAILABLE_TITLE".localized, message: "INTERNET_UNAVAILABLE_TEXT".localized, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskListRows.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCellIdentifier.Default.rawValue, forIndexPath: indexPath) as! TaskTableViewCell
        
        let taskListRow = taskListRows[indexPath.row]
        
        cell.titleLabel.text = "\(taskListRow)"
        cell.iconLabel.text = logos[indexPath.row]
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 170
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
       if(!Reachability.isConnected()){
            showAlert()
        }
        else {
        
        // Present the task view controller that the user asked for.
        let taskListRow = taskListRows[indexPath.row]
        
        // Create a task from the `TaskListRow` to present in the `ORKTaskViewController`.
        let task = taskListRow.representedTask
        
        /*
        Passing `nil` for the `taskRunUUID` lets the task view controller
        generate an identifier for this run of the task.
        */
        let taskViewController = ORKTaskViewController(task: task, taskRunUUID: nil)
        
        // Make sure we receive events from `taskViewController`.
        taskViewController.delegate = self
        taskViewController.outputDirectory = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)[0] as NSURL
        
        
        /*
        We present the task directly, but it is also possible to use segues.
        The task property of the task view controller can be set any time before
        the task view controller is presented.
        */
        presentViewController(taskViewController, animated: true, completion: nil)
        }
    }
    func taskViewController(taskViewController: ORKTaskViewController, stepViewControllerWillAppear stepViewController: ORKStepViewController) {
        
        
        let identifier = stepViewController.step?.identifier
        
        stepViewController.skipButtonTitle = "Ønsker ikke å svare / ikke relevant"
        
        if identifier == Identifier.MathysCompletionStep.rawValue || identifier == Identifier.SleepCompletionStep.rawValue {
            stepViewController.continueButtonTitle = "Send inn"
        }
        
        if identifier == Identifier.WaitCompletionStep.rawValue {
            stepViewController.cancelButtonItem = nil
            delay(2.0, closure: { () -> () in
                if let stepViewController = stepViewController as? ORKWaitStepViewController {
                    stepViewController.goForward()
                }
            })
        }
    }
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    // MARK: ORKTaskViewControllerDelegate
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        /*
        The `reason` passed to this method indicates why the task view
        controller finished: Did the user cancel, save, or actually complete
        the task; or was there an error?
        
        The actual result of the task is on the `result` property of the task
        view controller.
        */
        taskResultFinishedCompletionHandler?(taskViewController.result)
        
        let taskResult = taskViewController.result
        
        var list = [String]()
        list.append("Task: \(taskResult.identifier)")
        list.append("Respondent Study ID: \(UserDefaults.objectForKey(UserDefaultKey.StudyID)!)")
        list.append("Respondent UUID: \(UserDefaults.objectForKey(UserDefaultKey.UUID)!)")
        list.append("startDate: \(taskResult.startDate!)")
        list.append("endDate: \(taskResult.endDate!)")
        list.append("Total time: \(taskResult.endDate!.timeIntervalSinceDate(taskResult.startDate!)) seconds")
        
        let stepResults = taskResult.results!
        
        if let stepResults = taskResult.results as? [ORKStepResult] {
            for stepResult in stepResults {
                for result in stepResult.results! {
                    if let scaleResult = result as? ORKScaleQuestionResult {
                        if let answer = scaleResult.answer {
                            list.append("\(scaleResult.identifier): \(answer)")
                        } else {
                            list.append("\(scaleResult.identifier): \(scaleResult.answer)")
                        }
                    }
                    if let choiceResult = result as? ORKChoiceQuestionResult {
                        if let _ = choiceResult.answer {
                            list.append("\(choiceResult.identifier): \(choiceResult.choiceAnswers![0])")
                        } else {
                            list.append("\(choiceResult.identifier): \(choiceResult.answer)")
                        }
                    }
                    if let textResult = result as? ORKTextQuestionResult {
                        if let answer = textResult.answer {
                            list.append("\(textResult.identifier): \(answer)")
                        } else {
                            list.append("\(textResult.identifier): \(textResult.answer)")
                        }
                    }
                }
            }
        }
        
        print(list)
        print("Number of steps completed:  \(stepResults.count)")
        let csv = CSVProcesser(taskResult: taskResult)
        print(csv.csv)
        
        
        //self.nettskjema.setExtraField("\(taskViewController.result.identifier)", result: taskViewController.result)
        //self.nettskjema.submit()
        
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
   /* func taskViewController(taskViewController: ORKTaskViewController, stepViewControllerWillAppear stepViewController: ORKStepViewController) {
        let identifier = stepViewController.step?.identifier
        
        stepViewController.skipButtonTitle = "Ønsker ikke å svare / ikke relevant"
        
        if identifier == Identifier.MathysCompletionStep.rawValue || identifier == Identifier.SleepCompletionStep.rawValue {
            stepViewController.continueButtonTitle = "Send inn"
        }
    }*/
    
    func presentWeeklySurvey() {
        let taskListRow = taskListRows[0]
        let task = taskListRow.representedTask
        let taskViewController = ORKTaskViewController(task: task, taskRunUUID: nil)
        presentViewController(taskViewController, animated: false, completion: nil)
    }
    
    func presentDailySurvey() {
        let taskListRow = taskListRows[1]
        let task = taskListRow.representedTask
        let taskViewController = ORKTaskViewController(task: task, taskRunUUID: nil)
        presentViewController(taskViewController, animated: false, completion: nil)
    }
    
    func animateSettingsIconWithDuration(duration: Double) {
        let settingsView: UIView = settingsIcon.valueForKey("view") as! UIView
        UIView.animateWithDuration(duration, animations: {
            settingsView.transform = CGAffineTransformMakeRotation((90.0 * CGFloat(M_PI)) / 90.0)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This function will disable the task and add overlay image
    //boolean taskShouldBeDisable must be implemented
    
    func addDisableOverlay(cell: UITableViewCell, indexPath: Int){
    
     let navigationBarHeight = self.navigationController?.navigationBar.frame.height
     
     let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
     
     let yPos = cell.bounds.minY + navigationBarHeight! + statusBarHeight
     
     let point = CGPoint(x:cell.bounds.minX , y: yPos)
     
     let size = CGSize(width: cell.bounds.width, height: cell.bounds.height)
     
     let rect = CGRect(origin: point, size: size)
     
     let disableImage = UIImageView(frame: rect)
     disableImage.backgroundColor = UIColor.grayColor()
     disableImage.alpha = 0.5
     
     //if(taskShouldBeDisabled) {
     
     //for disable the task
     //cell.userInteractionEnabled = false
     
     //adding overlay
     self.navigationController?.view.addSubview(disableImage)
     
     //else if(!taskShouldBeDisabled) {
     //cell.userInteractionEnabled = true
     //self.navigationController?.view.willRemoveSubview(disableImage)

     
     
     cell.userInteractionEnabled = true
     //self.navigationController?.view.willRemoveSubview(disableImage)
     }

}
