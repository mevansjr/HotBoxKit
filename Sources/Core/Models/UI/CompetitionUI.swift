//
//  CompetitionUI.swift
//  HotBox
//
//  Created by Mark Evans on 5/21/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//

import Foundation

class CompetitionUI: NSObject, Mappable {
    var competitionId : String?
    var name : String?
    var organizationId : String?

    class func newInstance(_ map: Map) -> Mappable? {
        return CompetitionUI()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map) {
        competitionId <- map["competitionId"]
        name <- map["name"]
        organizationId <- map["organizationId"]
    }
}
