//
//  CSVProcesser.swift
//  MinDag
//
//  Created by Paul Philip Mitchell on 27/01/16.
//  Copyright © 2016 Universitetet i Oslo. All rights reserved.
//

import Foundation
import ResearchKit

public class CSVProcesser {
    
    let rid = UserDefaults.objectForKey(UserDefaultKey.UUID)!
    let sid = UserDefaults.objectForKey(UserDefaultKey.StudyID)!
    
    var csv: String = ""
    
    var description: String {
        return csv
    }
    
    
    init(taskResult: ORKTaskResult) {
        
        csv += "\(appendMetadata(taskResult))"
        csv += "\(appendResultData(taskResult))"
    }
    
    func appendMetadata(taskResult: ORKTaskResult) -> String {
        return "\(taskResult.identifier)," +
               "\(rid)," +
               "\(sid)," +
               "\(taskResult.startDate!)," +
               "\(taskResult.endDate!)," +
               "\(taskResult.endDate!.timeIntervalSinceDate(taskResult.startDate!)),"
    }
    
    func appendResultData(taskResult: ORKTaskResult) -> String {
        
        var resultString = ""
        
        if let stepResults = taskResult.results as? [ORKStepResult] {
            for stepResult in stepResults {
                for result in stepResult.results! {
                    if let scaleResult = result as? ORKScaleQuestionResult {
                        if let answer = scaleResult.answer {
                            resultString += "\(answer),"
                        } else {
                            resultString += "\(scaleResult.answer),"
                        }
                    }
                    if let choiceResult = result as? ORKChoiceQuestionResult {
                        if let _ = choiceResult.answer {
                            resultString += "\(choiceResult.choiceAnswers![0]),"
                        } else {
                            resultString += "\(choiceResult.answer),"
                        }
                    }
                    if let textResult = result as? ORKTextQuestionResult {
                        if let answer = textResult.answer {
                            resultString += "\(answer)"
                        } else {
                            resultString += "\(textResult.answer)"
                        }
                    }
                }
            }
        }
        
        return resultString
    }
    
}