//
//  NettskjemaHandler.swift
//  Mathys
//
//  Created by Paul Philip Mitchell on 16/12/15.
//  Copyright © 2015 Universitetet i Oslo. All rights reserved.
//


import Foundation
import UIKit
import ResearchKit
import Alamofire
import Locksmith

private enum Field: String {
    case csrf = "NETTSKJEMA_CSRF_PREVENTION"
    case studyId = "answersAsMap[551950].textAnswer"
    case appId = "answersAsMap[551951].textAnswer"
    case date = "answersAsMap[551952].textAnswer"
    case time = "answersAsMap[551953].textAnswer"
    case dateTime = "answersAsMap[551954].textAnswer"
    case hoursSlept = "answersAsMap[551955].answerOptions"
    case sleepQuality = "answersAsMap[551956].textAnswer"
}

let hoursSleptOptions = [
    0: "1217827",
    1: "1217828",
    2: "1217829",
    3: "1217830",
    4: "1217831",
    5: "1217832",
    6: "1217833",
    7: "1217834",
    8: "1217835",
    9: "1217836",
    10: "1217837",
    11: "1217838",
    12: "1217839",
    13: "1217840",
    14: "1217841",
    15: "1217842",
]

private extension MultipartFormData {
    func addString(value: String, field: Field) {
        self.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: field.rawValue)
    }
    
    func addFormattedDateTime(time: NSDate, format: String, field: Field) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        self.addString(formatter.stringFromDate(time), field: field)
    }
}

class Nettskjema {
    private static let pingUrl = "https://nettskjema.uio.no/ping.html"
    private static let formUrl = "https://nettskjema.uio.no/answer/deliver.json?formId=73906"
    
    private static var csrfToken: String?
    
    private class func getCsrfToken(completion: (String?, NSError?) -> Void) -> () {
        Alamofire.request(.GET, pingUrl)
            .validate()
            .responseString { response in
                switch response.result {
                case .Success(let data):
                    self.csrfToken = data
                    completion(data, nil)
                    NSLog("Request succeeded with data: \(data)")
                case .Failure(let error):
                    completion(nil, error)
                }
        }
    }
    
    private class func post(valueAdder: (MultipartFormData) -> Void, time: NSDate, csrf: String) {
        Alamofire.upload(
            .POST,
            formUrl,
            multipartFormData: {
                $0.addString(csrf, field: Field.csrf)
                $0.addString(Locksmith.loadDataForUserAccount(Encrypted.account)![Encrypted.studyID]! as! String, field: Field.studyId)
                $0.addString(UserDefaults.objectForKey(UserDefaultKey.UUID)! as! String, field: Field.appId)
                $0.addFormattedDateTime(time, format: "yyyy-MM-dd", field: Field.date)
                $0.addFormattedDateTime(time, format: "HH:mm:ss", field: Field.time)
                $0.addFormattedDateTime(time, format: "yyyy-MM-dd HH:mm:ss", field: Field.dateTime)
                valueAdder($0)
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseString { response in
                        print(response)
                        NSLog("Upload success. Status code: \(response.response?.statusCode)")
                    }
                case .Failure(let encodingError):
                    NSLog("Upload failed. Error: \(encodingError)")
                }
        })
    }
    
    private class func submit(using dataAdder: (MultipartFormData) -> Void, time: NSDate) {
        getCsrfToken { (data, error) in
            if let token = data {
                self.post(dataAdder, time: time, csrf: token)
            } else {
                NSLog("Failed to get CSRF token with error: \(error!)")
            }
        }
    }
    
    private class func submit(sleep hours: String?, quality: String?, time: NSDate) {
        submit(using: { data in
            if let hoursValue = hours { data.addString(hoursValue, field: Field.hoursSlept) }
            if let qualityValue = quality { data.addString(qualityValue, field: Field.sleepQuality) }
            },
               time: time)
    }
    
    class func submit(hours: Int?, quality: Int?, time: NSDate) {
        submit(sleep: hours != nil ? hoursSleptOptions[hours!] : nil, quality: quality != nil ? String(quality!) : nil, time: time)
    }
    
}



