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
               "\(NSInteger(taskResult.endDate!.timeIntervalSinceDate(taskResult.startDate!))),"
    }
    
    func appendResultData(taskResult: ORKTaskResult) -> String {
        
        var fields: [String] = []
        
        if let stepResults = taskResult.results as? [ORKStepResult] {
            for stepResult in stepResults {
                for result in stepResult.results! {
                    if let scaleResult = result as? ORKScaleQuestionResult {
                        if let answer = scaleResult.answer {
                            fields.append(answer as! String)
                        } else {
                            fields.append(scaleResult.answer as! String)
                        }
                    }
                    if let choiceResult = result as? ORKChoiceQuestionResult {
                        if let _ = choiceResult.answer {
                           fields.append(choiceResult.choiceAnswers![0] as! String)
                        } else {
                            fields.append(choiceResult.answer as! String)
                        }
                    }
                    if let textResult = result as? ORKTextQuestionResult {
                        if let answer = textResult.answer {
                            fields.append(answer as! String)
                        } else {
                            fields.append(textResult.answer as! String)
                        }
                    }
                }
            }
        }
        
        return fields.joinWithSeparator(",")

    }
    
}