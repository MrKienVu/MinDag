//
//  SlidersExampleTask.swift
//  Mathys
//
//  Created by ingeborg ødegård oftedal on 16/12/15.
//  Copyright © 2015 ingeborg ødegård oftedal. All rights reserved.
//

import Foundation
import ResearchKit

public var SlidersExampleTask: ORKOrderedTask {

    let step = ORKFormStep (identifier: String(Identifier.FormStep), title: "MAThyS (Multidimensional Assessment of Thymic States) by Henry et al.", text:"This scale aims to evaluate your mood during the last week. For each item, indicate how you  usually feel by making a vertical line between the two  opposite statements." )
    
   //let exampleQuestionText = "SLIDERS_QUESTION_TEXT".localized
    
    let exampleQuestionText = "Hvor sensitiv til farge er du?"
    
    //let exampleHighValueText = "SLIDERS_HIGHVALUE_TEXT".localized
    
    let exampleHighValueText = "Veldig sensitiv"
    let exampleHighValueText2 = "I am more sensitive to colours than usual"
    
    //let exampleLowValueText = "SLIDERS_LOWVALUE_TEXT".localized
    
    let exampleLowValueText = "Lite sensitiv"
    let exampleLowValueText2 = "I am less sensitive to colours than usual"
    
    //let exampleDetailText = "SLIDERS_DETAIL_TEXT".localized
    
    _ = "Indiker hva du vanligvis føler"
    _ = "For each item, indicate how you  usually feel by making a vertical line between the two  opposite statements."

    let step1AnswerFormat = ORKAnswerFormat.scaleAnswerFormatWithMaximumValue(10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: false, maximumValueDescription: exampleHighValueText, minimumValueDescription: exampleLowValueText)
    
    let formItem01 = ORKFormItem(identifier: String(Identifier.DiscreteScaleQuestionStep), text: exampleQuestionText, answerFormat: step1AnswerFormat)
    
    let step3AnswerFormat = ORKAnswerFormat.scaleAnswerFormatWithMaximumValue(10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: true, maximumValueDescription: exampleHighValueText2, minimumValueDescription: exampleLowValueText2)
    
    let longAns = ORKAnswerFormat.scaleAnswerFormatWithMaximumValue(10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: false, maximumValueDescription: exampleHighValueText2, minimumValueDescription: exampleLowValueText2)
    
    let formItem001 = ORKFormItem(identifier: String(Identifier.TestStep1), text: "", answerFormat: longAns)
    
    let formItem02 = ORKFormItem(identifier: String(Identifier.DiscreteVerticalScaleQuestionStep), text: "", answerFormat: step3AnswerFormat)
    
    let long2s = ORKAnswerFormat.scaleAnswerFormatWithMaximumValue(10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: true, maximumValueDescription: exampleHighValueText, minimumValueDescription: exampleLowValueText)
    
    let formItem002 = ORKFormItem(identifier: String(Identifier.TestStep2), text: exampleQuestionText, answerFormat: long2s)
    
    /*let moodQuestionStepAnswerFormat = ORKAnswerFormat.continuousScaleAnswerFormatWithMaximumValue(100.0, minimumValue: 0.0, defaultValue: 50.0, maximumFractionDigits: 0, vertical: false, maximumValueDescription: exampleHighValueText, minimumValueDescription: exampleLowValueText)
    
    
    let moodQuestionStep = ORKFormItem(identifier: Identifier.MoodQuestionStep.rawValue, text: "", answerFormat: moodQuestionStepAnswerFormat) */
    
    
    step.formItems = [
        formItem001,
        formItem02,
        formItem01,
       // moodQuestionStep,
        formItem002
    ]
    
    return ORKOrderedTask(identifier: String(Identifier.FormTask), steps: [step])
}
