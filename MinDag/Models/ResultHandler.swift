//
//  CSVProcesser.swift
//  MinDag
//
//  Created by Paul Philip Mitchell on 27/01/16.
//  Copyright © 2016 Universitetet i Oslo. All rights reserved.
//

import Foundation
import ResearchKit

public class ResultHandler {
    
    private static let respondentID = UserDefaults.objectForKey(UserDefaultKey.UUID)! as! String
    private static let studyID = UserDefaults.objectForKey(UserDefaultKey.StudyID)! as! String
    
    class func createCSVFromResult(result: ORKTaskResult) -> NSData? {
        let metadata = getMetadata(result)
        let resultdata = getResultData(result)
        
        let headers = (metadata[0] + resultdata[0]).joinWithSeparator(",")
        let fields = (metadata[1] + resultdata[1]).joinWithSeparator(",")
        
        return "\(headers)\n\(fields)".dataUsingEncoding(NSUTF8StringEncoding)
    }

    
    private class func getMetadata(taskResult: ORKTaskResult) -> [[String]] {
        let headers = ["Task", "RespondentID", "StudyID", "StartDate", "EndDate", "TotalTime"]
        let fields = [taskResult.identifier, respondentID, studyID, taskResult.startDate!.toStringDetailed(), taskResult.endDate!.toStringDetailed(), "\(NSInteger(taskResult.endDate!.timeIntervalSinceDate(taskResult.startDate!)))"]
        
        return [headers, fields]
    }
    
    private class func getResultData(taskResult: ORKTaskResult) -> [[String]] {
        var counter = 1
        var headers: [String] = []
        var fields: [String] = []
        
        if let stepResults = taskResult.results as? [ORKStepResult] {
            for stepResult in stepResults {
                for result in stepResult.results! {
                    if let scaleResult = result as? ORKScaleQuestionResult {
                        headers.append("Question\(counter)")
                        counter += 1
                        if let answer = scaleResult.answer {
                            fields.append("\(answer)")
                        } else {
                            fields.append("\(scaleResult.answer)")
                        }
                    }
                    if let choiceResult = result as? ORKChoiceQuestionResult {
                        headers.append("Question\(counter)")
                        counter += 1
                        if let _ = choiceResult.answer {
                           fields.append("\(choiceResult.choiceAnswers![0])")
                        } else {
                            fields.append("\(choiceResult.answer)")
                        }
                    }
                    if let textResult = result as? ORKTextQuestionResult {
                        headers.append("Question\(counter)")
                        counter += 1
                        if let answer = textResult.answer {
                            fields.append("\(answer)")
                        } else {
                            fields.append("\(textResult.answer)")
                        }
                    }
                }
            }
        }
        
        return [headers, fields]

    }
    
}