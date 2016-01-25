//
//  Identifier.swift
//  Mathys
//
//  Created by Paul Philip Mitchell on 17/12/15.
//  Copyright © 2015 Universitetet i Oslo. All rights reserved.
//

import Foundation
/**
 Every step and task in the ResearchKit framework has to have an identifier. Within a
 task, the step identifiers should be unique.
 
 Here we use an enum to ensure that the identifiers are kept unique. Since
 the enum has a raw underlying type of a `String`, the compiler can determine
 the uniqueness of the case values at compile time.
 
 */

enum Identifier: String {
    
    // Survey Task
    case SurveyTask =                                   "SurveyTask"
    case IntroStep =                                    "IntroStep"
    
    // Sliders Example Task
    case FormTask =                                     "FormTask"
    case FormStep =                                     "FormStep"
    case TestStep1 =                                    "TestStep1"
    case TestStep2 =                                    "TestStep2"
    case DiscreteScaleQuestionStep =                    "DiscreteScaleQuestionStep"
    case DiscreteVerticalScaleQuestionStep =            "DiscreteVerticalScaleQuestionStep"
    case TextVerticalScaleQuestionStep =                "TVSQS"
    case TextHorizontalScaleQuestionStep =              "THSQS"
    
    // Sleep Survey Task
    case SleepSurveyTask =                              "SleepSurveyTask"
    case SleepInstructionStep =                         "SleepInstructionStep"
    case HoursOfSleepStep =                             "HoursOfSleepStep"
    case SleepQualityStep =                             "SleepQuality"
    case SleepCompletionStep =                          "SleepCompletionStep"
    
    // Mathys Survey
    case MathysTask =                                   "MathysTask"
    case MathysInstructionStep =                        "MathysInstructionStep"
    case ScaleQuestion =                                "ScaleQuestion"
    case MathysScaleCompletionStep =                    "MathysScaleCompletionStep"
    case MathysInstructionStep2 =                       "MathysInstructionStep2"
    case TextChoiceQuestion =                           "TextChoiceQuestion"
    case TestQuestionStep =                             "TextQuestionStep"
    case MathysTextChoiceCompletionStep =               "MathysTextChoiceCompletionStep"
}