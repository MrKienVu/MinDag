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
    
    //Array for values in the picker
    var pickerValueChoice = [ORKTextChoice]()
    
    for(var i = 0; i < 15;i++){
        var textValue = NSLocalizedString("\(i)", comment: "")
    
        if(i == 14) {
            textValue = NSLocalizedString(">\(i)", comment: "")
        }
        
        pickerValueChoice.append(ORKTextChoice (text: textValue, value: i))
    }   
    
    let answerFormat = ORKAnswerFormat.valuePickerAnswerFormatWithTextChoices(pickerValueChoice)
    
    let questionStep = ORKQuestionStep(identifier: String(Identifier.SleepSurveyStep), title: "Velg antall timer sovet",
        answer: answerFormat)
    
    questionStep.text = ""
    
    steps+=[questionStep]
    
    return ORKOrderedTask(identifier: Identifier.SleepSurveyTask.rawValue, steps: steps)
}
