//
//  GameApi.swift
//  HotBox
//
//  Created by Mark Evans on 3/19/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//

import Foundation

class GameApi : NSObject, Mappable {
    var gameId : String?
    var awayTeam : TeamApi?
    var competitionId : Int = 0
    var competitionName : String?
    var homeTeam : TeamApi?
    var isEligibleForMarketplace : Bool = false
    var periodsApi = [PeriodApi]()
    var startDateTimestamp : Double?
    var status : Int = 0

    class func newInstance(_ map: Map) -> Mappable? {
        return GameApi()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map) {
        gameId <- map["id"]
        awayTeam <- map["awayTeam"]
        competitionId <- map["competitionId"]
        competitionName <- map["competitionName"]
        homeTeam <- map["homeTeam"]
        isEligibleForMarketplace <- map["isEligibleForMarketplace"]
        periodsApi <- map["periods"]
        startDateTimestamp <- map["startDateTimestamp"]
        status <- map["status"]
    }
}

//extension GameApi {
//    var name: String {
//        return "\(self.awayTeam?.teamId ?? "") @ \(self.homeTeam?.teamId ?? "")"
//    }
//
//    var periods: [Period] {
//        var periods_ = [Period]()
//        self.periodsApi.forEach { (period) in
//            periods_.append(Period(name: period.name, awayScore: period.awayScore, homeScore: period.homeScore, sortOrder: period.sortOrder, status: period.status))
//        }
//        return periods_
//    }
//}

class PeriodApi : NSObject, Mappable {
    var periodId: String?
    var name: String = ""
    var awayScore: Int?
    var homeScore: Int?
    var sortOrder: Int = 0
    var status: Int = 0

    class func newInstance(_ map: Map) -> Mappable? {
        return PeriodApi()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map) {
        periodId <- map["id"]
        name <- map["name"]
        awayScore <- map["awayScore"]
        homeScore <- map["homeScore"]
        sortOrder <- map["order"]
        status <- map["status"]
    }
}
