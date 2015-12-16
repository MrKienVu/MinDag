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
    
    let exampleQuestionText = NSLocalizedString("Your question goes here.", comment: "")
    
    let exampleHighValueText = NSLocalizedString("High Value", comment: "")
    
    let exampleLowValueText = NSLocalizedString("Low Value", comment: "")
    
    let exampleDetailText = NSLocalizedString("Additional text can go here.", comment: "")

    
    var steps = [ORKStep]()
    
    let step1AnswerFormat = ORKAnswerFormat.scaleAnswerFormatWithMaximumValue(10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: false, maximumValueDescription: exampleHighValueText, minimumValueDescription: exampleLowValueText)
    
    
    
    let questionStep1 = ORKQuestionStep(identifier: String(Identifier.DiscreteScaleQuestionStep), title: exampleQuestionText, answer: step1AnswerFormat)
    
    questionStep1.text = exampleDetailText
    
    steps += [questionStep1]
    
    // The second step is a scale control that allows continuous movement with a percent formatter.
    let step2AnswerFormat = ORKAnswerFormat.continuousScaleAnswerFormatWithMaximumValue(1.0, minimumValue: 0.0, defaultValue: 99.0, maximumFractionDigits: 0, vertical: false, maximumValueDescription: nil, minimumValueDescription: nil)
    step2AnswerFormat.numberStyle = .Percent
    
    let questionStep2 = ORKQuestionStep(identifier: String(Identifier.ContinuousScaleQuestionStep), title: exampleQuestionText, answer: step2AnswerFormat)
    
    questionStep2.text = exampleDetailText
    
    steps += [questionStep2]
    
    // The third step is a vertical scale control with 10 discrete ticks.
    let step3AnswerFormat = ORKAnswerFormat.scaleAnswerFormatWithMaximumValue(10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: true, maximumValueDescription: nil, minimumValueDescription: nil)
    
    let questionStep3 = ORKQuestionStep(identifier: String(Identifier.DiscreteVerticalScaleQuestionStep), title: exampleQuestionText, answer: step3AnswerFormat)
    
    questionStep3.text = exampleDetailText
    
    steps += [questionStep3]
    
    // The fourth step is a vertical scale control that allows continuous movement.
    let step4AnswerFormat = ORKAnswerFormat.continuousScaleAnswerFormatWithMaximumValue(5.0, minimumValue: 1.0, defaultValue: 99.0, maximumFractionDigits: 2, vertical: true, maximumValueDescription: exampleHighValueText, minimumValueDescription: exampleLowValueText)
    
    let questionStep4 = ORKQuestionStep(identifier: String(Identifier.ContinuousVerticalScaleQuestionStep), title: exampleQuestionText, answer: step4AnswerFormat)
    
    questionStep4.text = exampleDetailText
    
    steps += [questionStep4]
    
    // The fifth step is a scale control that allows text choices.
    let textChoices : [ORKTextChoice] = [ORKTextChoice(text: "Poor", value: 1), ORKTextChoice(text: "Fair", value: 2), ORKTextChoice(text: "Good", value: 3), ORKTextChoice(text: "Above Average", value: 10), ORKTextChoice(text: "Excellent", value: 5)]
    
    let step5AnswerFormat = ORKAnswerFormat.textScaleAnswerFormatWithTextChoices(textChoices, defaultIndex: NSIntegerMax, vertical: false)
    
    let questionStep5 = ORKQuestionStep(identifier: String(Identifier.TextScaleQuestionStep), title: exampleQuestionText, answer: step5AnswerFormat)
    
    questionStep5.text = exampleDetailText
    
    steps += [questionStep5]
    
    // The sixth step is a vertical scale control that allows text choices.
    let step6AnswerFormat = ORKAnswerFormat.textScaleAnswerFormatWithTextChoices(textChoices, defaultIndex: NSIntegerMax, vertical: true)
    
    let questionStep6 = ORKQuestionStep(identifier: String(Identifier.TextVerticalScaleQuestionStep), title: exampleQuestionText, answer: step6AnswerFormat)
    
    questionStep6.text = exampleDetailText
    
    steps += [questionStep6]
    
    return ORKOrderedTask(identifier: Identifier.SurveyTask.rawValue, steps: steps)
}
