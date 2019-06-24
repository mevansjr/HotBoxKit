//
//  ActivityLogUI.swift
//  HotBox
//
//  Created by Erik Uecke on 5/22/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//

import Foundation

class ActivityLogUI: NSObject, Mappable {
    var nameText: String?
    var dateText: String?
    var primaryActionHidden: Bool?
    var primaryActionConstraint: Double?
    var cancelActionContraint: Double?
    var cancelActionHidden: Bool?
    
    class func newInstance(_ map: Map) -> Mappable? {
        return ActivityLogUI()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map) {
        nameText <- map["activityName"]
        dateText <- map["activityDate"]
        primaryActionHidden <- map["primaryActionHidden"]
        primaryActionConstraint <- map["primaryActionConstrainte"]
        cancelActionContraint <- map["cancelActionContraint"]
        cancelActionHidden <- map["cancelActionHidden"]
    }
}
