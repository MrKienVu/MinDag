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
    
    for (var i = 0; i < 16;i++){
        var textValue = "\(i) timer"
        
        if i == 0   { textValue = "Sov ikke" }
        if i == 1   { textValue = "\(i) time" }
        if i == 15  { textValue = "mer enn 14 timer" }
        
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
