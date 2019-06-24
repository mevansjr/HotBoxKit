//
//  CompetitionApi.swift
//  HotBox
//
//  Created by Mark Evans on 5/20/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//

import Foundation

class CompetitionApi : NSObject, Mappable {
    var competitionId : String?
    var name : String?
    var organizationId : String?
    var sportId : String?

    class func newInstance(_ map: Map) -> Mappable? {
        return CompetitionApi()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map) {
        competitionId <- map["id"]
        name <- map["name"]
        organizationId <- map["organizationId"]
        sportId <- map["sportId"]
    }
}

