import Foundation
import UIKit
import ResearchKit
import Alamofire
import Locksmith

private class FormSettings {
    
    private let csrf: String
    private let formId: String
    private let studyId: String
    private let appId: String
    private let date: String
    private let time: String
    private let dateTime: String
    private let hoursSlept: String
    private let sleepQuality: String
    private let hoursSleptOptions: [Int: String]
    
    init(csrf: String, formId: String, studyId: String, appId: String, date: String, time: String,
         dateTime: String, hoursSlept: String, sleepQuality: String, hours0: String, hours1: String,
         hours2: String, hours3: String, hours4: String, hours5: String, hours6: String, hours7: String,
         hours8: String, hours9: String, hours10: String, hours11: String, hours12: String, hours13: String,
         hours14: String, hours15: String) {
        
        self.csrf = "NETTSKJEMA_CSRF_PREVENTION"
        self.formId = formId
        self.studyId = textAnswer(studyId)
        self.appId = textAnswer(appId)
        self.date = textAnswer(date)
        self.time = textAnswer(time)
        self.dateTime = textAnswer(dateTime)
        self.hoursSlept = answerOptions(hoursSlept)
        self.sleepQuality = textAnswer(sleepQuality)
        
        self.hoursSleptOptions = [
            0: hours0,
            1: hours1,
            2: hours2,
            3: hours3,
            4: hours4,
            5: hours5,
            6: hours6,
            7: hours7,
            8: hours8,
            9: hours9,
            10: hours10,
            11: hours11,
            12: hours12,
            13: hours13,
            14: hours14,
            15: hours15,
        ]
    }
}

private func textAnswer(id: String) -> String {
    return "answersAsMap[\(id)].textAnswer"
}

private func answerOptions(id: String) -> String {
    return "answersAsMap[\(id)].answerOptions"
}

private extension MultipartFormData {
    func addString(value: String, field: String) {
        self.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: field)
    }
    
    func addFormattedDateTime(time: NSDate, format: String, field: String) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        self.addString(formatter.stringFromDate(time), field: field)
    }
}

class Nettskjema {
    private static let pingUrl = "https://nettskjema.uio.no/ping.html"
    private static let deliveryBaseUrl = "https://nettskjema.uio.no/answer/deliver.json?formId="
    private static var csrfToken: String?
    
    private static let testForm = FormSettings.init(
        csrf: "NETTSKJEMA_CSRF_PREVENTION", formId: "73906", studyId: "551950", appId: "551951",
        date: "551952", time: "551953", dateTime: "551954", hoursSlept: "551955",
        sleepQuality: "551956", hours0: "1217827", hours1: "1217828", hours2: "1217829",
        hours3: "1217830", hours4: "1217831", hours5: "1217832", hours6: "1217833",
        hours7: "1217834", hours8: "1217835", hours9: "1217836", hours10: "1217837",
        hours11: "1217838", hours12: "1217839", hours13: "1217840", hours14: "1217841",
        hours15: "1217842")
    
    private static let prodForm = FormSettings.init(
        csrf: "NETTSKJEMA_CSRF_PREVENTION", formId: "74114", studyId: "556038", appId: "556039",
        date: "556040", time: "556041", dateTime: "556042", hoursSlept: "556043",
        sleepQuality: "556044", hours0: "1225493", hours1: "1225494", hours2: "1225495",
        hours3: "1225496", hours4: "1225497", hours5: "1225498", hours6: "1225499",
        hours7: "1225500", hours8: "1225501", hours9: "1225502", hours10: "1225503",
        hours11: "1225504", hours12: "1225505", hours13: "1225506", hours14: "1225507",
        hours15: "1225508")
    
    private static let form = UserDefaults.boolForKey(
        UserDefaultKey.testModeEnabled) ? testForm : prodForm
    
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
    
    private class func post(valueAdder: (MultipartFormData) -> Void, time: NSDate, csrf: String, onFailure: () -> Void) {
        Alamofire.upload(
            .POST,
            deliveryBaseUrl + form.formId,
            multipartFormData: {
                $0.addString(csrf, field: form.csrf)
                $0.addString(Locksmith.loadDataForUserAccount(Encrypted.account)![Encrypted.studyID]! as! String, field: form.studyId)
                $0.addString(UserDefaults.objectForKey(UserDefaultKey.UUID)! as! String, field: form.appId)
                $0.addFormattedDateTime(time, format: "yyyy-MM-dd", field: form.date)
                $0.addFormattedDateTime(time, format: "HH:mm:ss", field: form.time)
                $0.addFormattedDateTime(time, format: "yyyy-MM-dd HH:mm:ss", field: form.dateTime)
                valueAdder($0)
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseString { response in
                        if String(response).containsString("failure") {
                            onFailure()
                            handleNettskjemaError(response)
                        }
                        NSLog("Upload success. Status code: \(response.response?.statusCode)")
                    }
                case .Failure(let encodingError):
                    onFailure()
                    NSLog("Upload failed. Error: \(encodingError)")
                }
        })
    }
    
    private class func handleNettskjemaError(response: Response<String, NSError>) {
        NSLog(response.debugDescription)
        fatalError()
    }
    
    private class func submit(using dataAdder: (MultipartFormData) -> Void, time: NSDate, onFailure: () -> Void) {
        getCsrfToken { (data, error) in
            if let token = data {
                self.post(dataAdder, time: time, csrf: token, onFailure: onFailure)
            } else {
                onFailure()
                NSLog("Failed to get CSRF token with error: \(error!)")
            }
        }
    }
    
    private class func submit(sleep hours: String?, quality: String?, time: NSDate, onFailure: () -> Void) {
        submit(using: { data in
            if let hoursValue = hours { data.addString(hoursValue, field: form.hoursSlept) }
            if let qualityValue = quality { data.addString(qualityValue, field: form.sleepQuality) }
            },
               time: time, onFailure: onFailure)
    }
    
    class func submit(hours: Int?, quality: Int?, time: NSDate, onFailure: () -> Void) {
        submit(sleep: hours != nil ? form.hoursSleptOptions[hours!] : nil, quality: quality != nil ? String(quality!) : nil, time: time, onFailure: onFailure)
    }    
}



