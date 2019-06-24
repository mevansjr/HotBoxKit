//
//  GameUI.swift
//  HotBox
//
//  Created by Mark Evans on 3/19/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//

import Foundation

class GameUI: NSObject, Mappable {
    var selector : Bool = false
    var gameId : String?
    var awayTeamName : String?
    var homeTeamName : String?
    var awayTeamScore : Int = 0
    var homeTeamScore : Int = 0
    var periodName : String?
    var status : Int = 0
    var entryFee : Int = 0
    var startDateTimestamp : Double?
    var isEligibleForMarketplace : Bool = false
    var periodsApi = [PeriodApi]()
//    var marketPlaceEntries = [MarketPlace]()
    var selected : Bool = false
    var startDateTimeUTC: Date?

    class func newInstance(_ map: Map) -> Mappable? {
        return GameUI()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map) {
        selector <- map["selector"]
        gameId <- map["gameId"]
        awayTeamName <- map["awayTeamName"]
        homeTeamName <- map["homeTeamName"]
        awayTeamScore <- map["awayTeamScore"]
        homeTeamScore <- map["homeTeamScore"]
        periodName <- map["periodName"]
        status <- map["status"]
        entryFee <- map["entryFee"]
        startDateTimestamp <- map["startDateTimestamp"]
        isEligibleForMarketplace <- map["isEligibleForMarketplace"]
        periodsApi <- map["periodsApi"]
//        marketPlaceEntries <- map["marketPlaceEntries"]
        selected <- map["selected"]
        startDateTimeUTC <- map["startDateTimeUTC"]
    }
}

//extension GameUI {
//    var name: String {
//        return "\(self.awayTeamName ?? "") @ \(self.homeTeamName ?? "") - \(self.entryFee.currency(digits: 0) ?? "")"
//    }
//
//    var nameShort: String {
//        return "\(self.awayTeamName ?? "") @ \(self.homeTeamName ?? "")"
//    }
//
//    func nameWithScores(away: Int, home: Int) -> String {
//        if DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPHONE_5 {
//            return "\(self.awayTeamName ?? "") \(away) @ \(self.homeTeamName ?? "") \(home)"
//        }
//        return "\(self.awayTeamName ?? "") - \(away) @ \(self.homeTeamName ?? "") - \(home)"
//    }
//
//    var periods: [Period] {
//        var periods_ = [Period]()
//        self.periodsApi.forEach { (period) in
//            periods_.append(Period(name: period.name, awayScore: period.awayScore, homeScore: period.homeScore, sortOrder: period.sortOrder, status: period.status))
//        }
//        return periods_
//    }
//
//    func currentPeriods(games: [Game]) -> [Period] {
//        if let game = games.filter({$0.id == self.gameId}).first {
//           return game.periods
//        }
//        return [Period]()
//    }
//
//    func syncItems(marketPlaceItems: [MarketPlace], selectedAway: Int, selectedHome: Int) -> [MarketPlace] {
//        let items = marketPlaceItems.sorted()
//        var marketItems = items.filter { (market) -> Bool in
//            if
//                let gameId = self.gameId,
//                    market.poolEntryFee == self.entryFee
//                    && market.gameId == gameId
//                    && market.marketplaceType == 0
//                    && selectedAway == market.awayScore
//                    && selectedHome == market.homeScore
//                    && market.isActive
//                    && market.expireDateTimeUTC.timeIntervalSince1970 > Date().timeIntervalSince1970
//            {
//                return true
//            }
//            return false
//        }
//        marketItems = marketItems.sorted(by: {$0.price < $1.price})
//        self.marketPlaceEntries = marketItems
//        return self.marketPlaceEntries
//    }
//
//    func syncItemsFromEntryFee(marketPlaceItems: [MarketPlace], selectedAway: Int, selectedHome: Int, entryFee: Int) -> [MarketPlace] {
//        let items = marketPlaceItems.sorted()
//        var marketItems = items.filter { (market) -> Bool in
//            if
//                let gameId = self.gameId,
//                    market.poolEntryFee == entryFee
//                    && market.gameId == gameId
//                    && market.marketplaceType == 0
//                    && selectedAway == market.awayScore
//                    && selectedHome == market.homeScore
//                    && market.isActive
//                    && market.expireDateTimeUTC.timeIntervalSince1970 > Date().timeIntervalSince1970
//            {
//                return true
//            }
//            return false
//        }
//        marketItems = marketItems.sorted(by: {$0.price < $1.price})
//        self.marketPlaceEntries = marketItems
//        return self.marketPlaceEntries
//    }
//
//}

class FilterUI: NSObject, Mappable {
    var gameId : String?
    var entryFee : Int?
    var showAllBoxes: Bool = true

    class func newInstance(_ map: Map) -> Mappable? {
        return FilterUI()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map) {
        gameId <- map["gameId"]
        entryFee <- map["entryFee"]
        showAllBoxes <- map["showAllBoxes"]
    }
}

class GameStatus: NSObject, Mappable {
    var clock : Double?
    var down : Int?
    var period : Int?
    var posession : String?
    var possession : String?
    var yardsToFirstDown : Int?
    var yardsToGoal : Int?

    class func newInstance(_ map: Map) -> Mappable? {
        return GameStatus()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map) {
        clock <- map["clock"]
        down <- map["down"]
        period <- map["period"]
        posession <- map["posession"]
        possession <- map["possession"]
        yardsToFirstDown <- map["yardsToFirstDown"]
        yardsToGoal <- map["yardsToGoal"]
    }
}

//extension GameStatus {
//    var downStatus: String? {
//        if let down = down, let yardToFirst = self.yardsToFirstDown {
//            return "\(down.numberEnding) & \(yardToFirst)"
//        }
//        return "1st & 10"
//    }
//
//    func yardStatus(_ away: String, _ home: String) -> String? {
//        let team = (yardLine > 50) ? (hasBallTeam.lowercased() == away.lowercased()) ? away : home : (hasBallTeam.lowercased() == away.lowercased()) ? home : away
//        let yardsLeft = (yardLine > 50) ? 100 - yardLine : yardLine
//        return "at \(team.uppercased()) \(yardsLeft)"
//    }
//
//    var clockStatus: String? {
//        if self.clock == nil { return "15:00" }
//        return self.clock!.msToSeconds.minuteSecond
//    }
//
//    var yardLine: Int {
//        return self.yardsToGoal ?? 0
//    }
//
//    var hasBallTeam: String {
//        var team = self.posession ?? ""
//        team = self.possession ?? team
//        return team
//    }
//
//    func teamHasBall(_ team: String) -> Bool {
//        return team.lowercased() == hasBallTeam.lowercased()
//    }
//}
