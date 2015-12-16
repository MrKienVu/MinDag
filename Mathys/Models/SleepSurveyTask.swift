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
    
    let text1 = NSLocalizedString("1", comment: "")
    let text2 = NSLocalizedString("2", comment: "")
    let text3 = NSLocalizedString("3", comment: "")
    let text4 = NSLocalizedString("4", comment: "")
    let text5 = NSLocalizedString("5", comment: "")
    let text6 = NSLocalizedString(">14", comment: "")

    
    let pickerValueChoice = [
        ORKTextChoice (text: text1, value: "1"),
        ORKTextChoice (text: text2, value: "2"),
        ORKTextChoice (text: text3, value: "3"),
        ORKTextChoice (text: text4, value: "4"),
        ORKTextChoice (text: text5, value: "5"),
        ORKTextChoice (text: text6, value: "14")
        ]
    

    let answerFormat = ORKAnswerFormat.valuePickerAnswerFormatWithTextChoices(pickerValueChoice)
    
    let questionStep = ORKQuestionStep(identifier: String(Identifier.SleepSurveyStep), title: "hvor lenge sov du",
        answer: answerFormat)
    
    questionStep.text = "yolo"
    
    steps+=[questionStep]

    
    return ORKOrderedTask(identifier: Identifier.SleepSurveyTask.rawValue, steps: steps)
}
