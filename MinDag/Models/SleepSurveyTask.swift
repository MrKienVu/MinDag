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
    introStep.image = UIImage(named: "sleep-icon")
    steps.append(introStep)
    
    //Array for values in the picker
    var pickerValueChoice = [ORKTextChoice]()
    
    for (var i = 0; i < 15;i++){
        var textValue = "\(i)"
    
        if(i == 14) {
            textValue = ">\(i)"
        }
        
        pickerValueChoice.append(ORKTextChoice(text: textValue, value: i))
    }   
    
    let answerFormat = ORKAnswerFormat.valuePickerAnswerFormatWithTextChoices(pickerValueChoice)
    
    let questionStep = ORKQuestionStep(
        identifier: Identifier.SleepSurveyStep.rawValue,
        title: "SLEEP_QUESTION_TITLE".localized,
        answer: answerFormat
    )
    
    questionStep.text = "SLEEP_QUESTION_TEXT".localized
    
    steps.append(questionStep)
    
    let sleepCompletionStep = ORKCompletionStep(identifier: Identifier.SleepCompletionStep.rawValue)
    sleepCompletionStep.title = "SLEEP_COMPLETION_TITLE".localized
    sleepCompletionStep.text = "SLEEP_COMPLETION_TEXT".localized
    steps.append(sleepCompletionStep)
    
    return ORKOrderedTask(identifier: Identifier.SleepSurveyTask.rawValue, steps: steps)
}
