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
    
    var i = 1
    var pickerValue = 1
    
    if(i < 14) {
        pickerValue = i
        i++
        ORKTextChoice(text: "verdi", value: pickerValue)
    }
        ORKTextChoice(text: "verdi", value: ">14")
    
    return ORKOrderedTask(identifier: Identifier.SurveyTask.rawValue, steps: steps)
}
