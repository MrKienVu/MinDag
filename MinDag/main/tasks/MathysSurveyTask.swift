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
    
    let instructionStep = ORKInstructionStep(identifier: Identifier.MathysInstructionStep.rawValue)
    instructionStep.title = "INTRO_TITLE".localized
    instructionStep.text = "INTRO_TEXT".localized
    steps.append(instructionStep)
    
    func verticalScaleWithHighValue(highValue: String, lowValue: String) -> ORKAnswerFormat {
        let answer = ORKAnswerFormat.scaleAnswerFormatWithMaximumValue(
            9,
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
            identifier: Identifier.ScaleQuestion.rawValue + "\(i)",
            title: "",
            text: nil,
            answer: verticalScaleWithHighValue(
                "SCALE_QUESTION_\(i)_HIGH".localized,
                lowValue: "SCALE_QUESTION_\(i)_LOW".localized
            )
        ))
    }
    
    let intermediateStep = ORKInstructionStep(identifier: Identifier.MathysIntermediateStep.rawValue)
    intermediateStep.title = "INTERMEDIATE_TITLE".localized
    intermediateStep.text = "INTERMEDIATE_TEXT".localized
    steps.append(intermediateStep)
    
    
    var textChoices = [ORKTextChoice]()
    for i in 1..<6 {
        textChoices.append(ORKTextChoice(text: "TEXT_CHOICE_\(i)".localized, value: i))
    }
    
    let textChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)

    for i in 1..<8 {
        steps.append(ORKQuestionStep(
            identifier: Identifier.TextChoiceQuestion.rawValue + "\(i)",
            title: "TEXT_CHOICE_\(i)_TITLE".localized,
            answer: textChoiceAnswerFormat
            )
        )
    }
    
    let textQuestionStep = ORKQuestionStep(
        identifier: Identifier.TextQuestionStep.rawValue,
        title: "TEXT_QUESTION_TITLE".localized,
        answer: ORKAnswerFormat.textAnswerFormat()
    )
    
    steps.append(textQuestionStep)
        
    let waitStepIndeterminate = ORKWaitStep(identifier: Identifier.WaitCompletionStep.rawValue)
    waitStepIndeterminate.title = "Ferdig"
    waitStepIndeterminate.text = "Laster opp..."
    waitStepIndeterminate.indicatorType = ORKProgressIndicatorType.Indeterminate
    steps.append(waitStepIndeterminate)
    
    return ORKOrderedTask(identifier: Identifier.MathysTask.rawValue, steps: steps)
}

