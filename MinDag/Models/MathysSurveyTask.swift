//
//  SlidersExampleTask.swift
//  Mathys
//
//  Created by ingeborg ødegård oftedal on 16/12/15.
//  Copyright © 2015 ingeborg ødegård oftedal. All rights reserved.
//

import Foundation
import ResearchKit

public var MathysSurveyTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    let introStep = ORKInstructionStep(identifier: String(Identifier.MathysInstructionStep))
    introStep.title = "INTRO_TITLE".localized
    introStep.text = "INTRO_TEXT".localized
    introStep.detailText = "INTRO_DETAIL".localized
    steps.append(introStep)
    
    func verticalScaleWithHighValue(highValue: String, lowValue: String) -> ORKAnswerFormat {
        let answer = ORKAnswerFormat.scaleAnswerFormatWithMaximumValue(
            10,
            minimumValue: 1,
            defaultValue: NSIntegerMax,
            step: 1,
            vertical: true,
            maximumValueDescription: highValue,
            minimumValueDescription: lowValue
        )
        answer.numberFormatter.positiveFormat = "\n"
        
        return answer
    }
    
    for i in 1..<21 {
        steps.append(ORKQuestionStep(
            identifier: String(Identifier.ScaleQuestion) + "\(i)",
            title: "Question \(i)",
            text: nil,
            answer: verticalScaleWithHighValue(
                "SCALE_QUESTION_\(i)_HIGH".localized,
                lowValue: "SCALE_QUESTION_\(i)_LOW".localized
            )
        ))
    }
    
    let scaleCompletionStep = ORKCompletionStep(identifier: String(Identifier.MathysScaleCompletionStep))
    scaleCompletionStep.title = "SCALE_COMPLETION_TITLE".localized
    scaleCompletionStep.text = "SCALE_COMPLETION_TEXT".localized
    scaleCompletionStep.detailText = "SCALE_COMPLETION_DETAIL".localized
    steps.append(scaleCompletionStep)
    
    let introStep2 = ORKInstructionStep(identifier: String(Identifier.MathysInstructionStep2))
    introStep2.title = "INTRO2_TITLE".localized
    introStep2.text = "INTRO2_TEXT".localized
    steps.append(introStep2)
    
    
    var textChoices = [ORKTextChoice]()
    for i in 1..<6 {
        textChoices.append(ORKTextChoice(text: "TEXT_CHOICE_\(i)".localized, value: "\(i)"))
    }
    
    let textChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)

    for i in 1..<8 {
        steps.append(ORKQuestionStep(
            identifier: String(Identifier.TextChoiceQuestion) + "\(i)",
            title: "TEXT_CHOICE_\(i)_TITLE".localized,
            answer: textChoiceAnswerFormat
            )
        )
    }
    
    let textQuestionStep = ORKQuestionStep(
        identifier: String(Identifier.TestQuestionStep),
        title: "TEXT_QUESTION_TITLE".localized,
        answer: ORKAnswerFormat.textAnswerFormat()
    )
    
    steps.append(textQuestionStep)
    
    let textChoiceCompletionStep = ORKCompletionStep(identifier: String(Identifier.MathysTextChoiceCompletionStep))
    textChoiceCompletionStep.title = "TEXTCHOICE_COMPLETION_TITLE".localized
    textChoiceCompletionStep.text = "TEXTCHOICE_COMPLETION_TEXT".localized
    steps.append(textChoiceCompletionStep)
    
    return ORKOrderedTask(identifier: String(Identifier.MathysTask), steps: steps)
}
