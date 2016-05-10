//
//  NoInternetConnectionStep.swift
//  MinDag
//
//  Created by ingeborg ødegård oftedal on 10/05/16.
//  Copyright © 2016 Universitetet i Oslo. All rights reserved.
//

import Foundation
import ResearchKit

class NoInternetConnectionStep : ORKActiveStep {
    
    static func stepViewControllerClass() -> NoInternetConnectionViewController.Type {
        return NoInternetConnectionViewController.self
    }
}
