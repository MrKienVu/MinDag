//
//  SleepSurveyTask.swift
//  Mathys
//
//  Created by ingeborg ødegård oftedal on 16/12/15.
//  Copyright © 2015 ingeborg ødegård oftedal. All rights reserved.
//

import Foundation
import ResearchKit

public var SleepSurveyTask: ORKOrderedTask {

    var steps = [ORKStep]()
    
    let introStep = ORKInstructionStep(identifier: Identifier.SleepInstructionStep.rawValue)
    introStep.title = "SLEEP_INTRO_TITLE".localized
    introStep.text = "SLEEP_INTRO_TEXT".localized
    introStep.image = UIImage(named: "daily-icon")
    steps.append(introStep)
    
    //Array for values in the picker
    var pickerValueChoice = [ORKTextChoice]()
    
    for i in 0 ..< 16{
        var textValue = "\(i) timer"
        
        if i == 0   { textValue = "Sov ikke" }
        if i == 1   { textValue = "\(i) time" }
        if i == 15  { textValue = "mer enn 14 timer" }
        
        pickerValueChoice.append(ORKTextChoice(text: textValue, value: i))
    }
    
    let answerFormat = ORKAnswerFormat.valuePickerAnswerFormatWithTextChoices(pickerValueChoice)
    
    let questionStep = ORKQuestionStep(
        identifier: Identifier.HoursOfSleepStep.rawValue,
        title: "SLEEP_QUESTION_TITLE".localized,
        answer: answerFormat
    )
    
    questionStep.text = "SLEEP_QUESTION_TEXT".localized
    
    steps.append(questionStep)
    
    let sleepQualityAnswer = ORKAnswerFormat.scaleAnswerFormatWithMaximumValue(5, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: true, maximumValueDescription: "SLEEP_QUALITY_GOOD".localized, minimumValueDescription: "SLEEP_QUALITY_BAD".localized)
    
    sleepQualityAnswer.numberFormatter.positiveFormat = "\n"
    
    let sleepQualityStep = ORKQuestionStep(identifier: Identifier.SleepQualityStep.rawValue, title: "SLEEP_QUALITY".localized, text: nil, answer: sleepQualityAnswer)
    
    steps.append(sleepQualityStep)
    
    let noInternetStep = ORKCompletionStep(identifier: Identifier.noInternetStep.rawValue)
    noInternetStep.title = "INTERNET_UNAVAILABLE_TITLE".localized
    noInternetStep.text = "INTERNET_UNAVAILABLE_STEP_TEXT".localized

    let waitStepIndeterminate = ORKWaitStep(identifier: Identifier.WaitCompletionStep.rawValue)
    waitStepIndeterminate.title = "Ferdig"
    waitStepIndeterminate.text = "Laster opp..."
    waitStepIndeterminate.indicatorType = ORKProgressIndicatorType.Indeterminate
    
    if (!Reachability.isConnected()){
        steps.append(noInternetStep)
        
    }
    else {
        steps.append(waitStepIndeterminate)
    }
    
    return ORKOrderedTask(identifier: Identifier.SleepSurveyTask.rawValue, steps: steps)
}
