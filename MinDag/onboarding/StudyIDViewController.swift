//
//  StudyIDViewController.swift
//  MinDag
//
//  Created by Paul Philip Mitchell on 19/02/16.
//  Copyright © 2016 Universitetet i Oslo. All rights reserved.
//

import UIKit

class StudyIDViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var repeatIdTextField: UITextField!
    @IBOutlet weak var checkmark: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func repeatIdChanged(sender: AnyObject) {
        if equalTextFields() {
            animateEqualTextfields()
        } else {
            animateInequalTextFields()
        }
    }
    
    @IBAction func IdChanged(sender: AnyObject) {
        if equalTextFields() {
            animateEqualTextfields()
        } else {
            animateInequalTextFields()
        }
    }
    
    func equalTextFields() -> Bool {
        if idTextField.text == repeatIdTextField.text && repeatIdTextField.text?.characters.count >= 3 {
            return true
        }
        
        return false
    }
    
    func animateEqualTextfields() {
        checkmark.hidden = false
        UIView.animateWithDuration(0.8, animations: {
            self.checkmark.alpha = 1.0
            self.nextButton.backgroundColor = Color.primaryColor
            self.nextButton.alpha = 1.0
        })
        nextButton.enabled = true
    }
    
    func animateInequalTextFields() {
        UIView.animateWithDuration(0.4, animations: {
            self.checkmark.alpha = 0.0
            self.nextButton.backgroundColor = Color.secondaryColor
            self.nextButton.alpha = 0.4
        })
        checkmark.hidden = true
        nextButton.enabled = false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        UserDefaults.setObject(repeatIdTextField.text!, forKey: UserDefaultKey.StudyID)
    }

}
