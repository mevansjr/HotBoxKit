//
//  PoolApi.swift
//  HotBox
//
//  Created by Mark Evans on 3/14/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//

import Foundation

class PoolApi : NSObject, Mappable {
    var poolId : String = ""
    var awayScoringIndex : [Int] = [Int]()
    var awayTeam : TeamApi = TeamApi()
    var competitionId : String = ""
    var entries : [String: Any] = [String: Any]()
    var entryFee : Int = 0
    var gameId : String?
    var gameStartDateTimestamp : Double = 0
    var homeScoringIndex : [Int] = [Int]()
    var homeTeam : TeamApi = TeamApi()
    var name : String = ""
    var status : Int = 0
    var totalNumEntries : Int = 0
    var rakePercentage : Int = 0
    var prizes : [PrizeApi] = [PrizeApi]()

    class func newInstance(_ map: Map) -> Mappable? {
        return PoolApi()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map) {
        poolId <- map["id"]
        awayScoringIndex <- map["awayScoringIndex"]
        awayTeam <- map["awayTeam"]
        competitionId <- map["competitionId"]
        entries <- map["entries"]
        entryFee <- map["entryFee"]
        gameId <- map["gameId"]
        gameStartDateTimestamp <- map["gameStartDateTimestamp"]
        homeScoringIndex <- map["homeScoringIndex"]
        homeTeam <- map["homeTeam"]
        name <- map["name"]
        status <- map["status"]
        totalNumEntries <- map["totalNumEntries"]
        rakePercentage <- map["rakePercentage"]
        prizes <- map["prizes"]
    }
}

class PrizeApi : NSObject, Mappable {
    var name : String = ""
    var amount : Int = 0
    var prizeAmount : Int = 0
    var rake : Int = 0
    var sortOrder : Int = 0

    class func newInstance(_ map: Map) -> Mappable? {
        return PrizeApi()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map) {
        name <- map["name"]
        amount <- map["amount"]
        prizeAmount <- map["prizeAmount"]
        rake <- map["rake"]
        sortOrder <- map["sortOrder"]
    }
}

class TeamApi : NSObject, Mappable {
    var teamId : String = ""
    var primaryColor : String = ""
    var secondaryColor : String = ""
    var sportId : String = ""
    var textColor : String = ""
    var name : String = ""

    class func newInstance(_ map: Map) -> Mappable? {
        return PoolApi()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map) {
        teamId <- map["id"]
        primaryColor <- map["primaryColor"]
        secondaryColor <- map["secondaryColor"]
        sportId <- map["sportId"]
        textColor <- map["textColor"]
        name <- map["name"]
    }
}

//extension PoolApi {
//    var arrayOfEntries: [Entry] {
//        var allEntries = [Entry]()
//        self.entries.forEach { (_, value) in
//            if let dict = value as? [String: Any] {
//                if
//                    let boxNumber = dict["boxNumber"] as? Int,
//                    let userId = dict["userId"] as? String,
//                    let userName = dict["userName"] as? String,
//                    let _ = dict["isForSale"],
//                    let _ = dict["salePrice"],
//                    let awayScore = dict["awayScore"] as? Int,
//                    let _ = dict["entryFee"],
//                    let _ = dict["history"],
//                    let entryId = dict["id"] as? String,
//                    let _ = dict["status"],
//                    let _ = dict["poolId"],
//                    let homeScore = dict["homeScore"] as? Int
//                {
//                    let entry = Entry(entryId: entryId, boxNumber: boxNumber, entryFee: self.entryFee, userId: userId, name: userName, isForSale: nil, salePrice: nil, status: 1, awayScore: awayScore, homeScore: homeScore)
//                    allEntries.append(entry)
//                }
//            }
//        }
//        allEntries = allEntries.sorted(by: {$0.boxNumber < $1.boxNumber})
//        return allEntries
//    }
//
//    var arrayOfEntriesMyBoxes: [Entry] {
//        var entries = self.arrayOfEntries
//        if self.totalNumEntries >= 100 || self.status > 0 {
//            entries = entries.sorted(by: {$0.awayHome < $1.awayHome})
//        }
//        else {
//            entries = entries.sorted(by: {$0.boxNumber < $1.boxNumber})
//        }
//        return entries
//    }
//    
//    func getUserEntriesFromPool(completion: @escaping CompletionHandler) {
//        var userBidEntries = [UserBidEntry]()
//        self.arrayOfEntries.forEach { (theEntry) in
//            let newUserEntry = UserBidEntry(awayScore: theEntry.awayScore, awayTeamId: self.awayTeam.teamId, awayTeamColor: self.awayTeam.primaryColor, boxNumber: theEntry.boxNumber, entryFee: theEntry.entryFee, entryId: theEntry.id ?? "", gameId: self.gameId ?? "", homeScore: theEntry.homeScore, homeTeamId: self.homeTeam.teamId, homeTeamColor: self.homeTeam.primaryColor, poolId: self.poolId)
//            userBidEntries.append(newUserEntry)
//        }
//        userBidEntries = userBidEntries.sorted(by: {$0.awayHome < $1.awayHome})
//        completion(userBidEntries, nil)
//    }
//}
