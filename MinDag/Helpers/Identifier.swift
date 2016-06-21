//
//  Identifier.swift
//  Mathys
//
//  Created by Paul Philip Mitchell on 17/12/15.
//  Copyright © 2015 Universitetet i Oslo. All rights reserved.
//

import Foundation
enum Identifier: String {
    
    // Sleep Survey Task
    case SleepSurveyTask =       "SleepSurveyTask"
    case SleepInstructionStep =  "SleepInstructionStep"
    case HoursOfSleepStep =      "HoursOfSleepStep"
    case SleepQualityStep =      "SleepQuality"
    case SleepCompletionStep =   "SleepCompletionStep"
    
    // Mathys Survey
    case MathysTask =             "MathysTask"
    case MathysInstructionStep =  "MathysInstructionStep"
    case ScaleQuestion =          "ScaleQuestion"
    case MathysIntermediateStep = "MathysIntermediateStep"
    case TextChoiceQuestion =     "TextChoiceQuestion"
    case TextQuestionStep =       "TextQuestionStep"
    case MathysCompletionStep =   "MathysCompletionStep"
    case WaitCompletionStep =     "WaitCompletionStep"
    
    case noInternetStep =         "NoInternetStep"
}