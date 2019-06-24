//
//  UserBidEntry.swift
//  HotBox
//
//  Created by Erik Uecke on 5/8/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//


import Foundation

public class UserBidEntry: NSObject, Mappable {
    
    var awayScore: Int = 0
    var awayTeamId: String?
    var awayTeamColor: String?
    var boxNumber: Int?
    var entryFee: Int = 0
    var entryId: String?
    var gameId: String? // gameId
    var homeScore: Int = 0
    var homeTeamId: String?
    var homeTeamColor: String?
    var poolId: String?
    
    public init(awayScore: Int, awayTeamId: String, awayTeamColor: String, boxNumber: Int, entryFee: Int, entryId: String, gameId: String, homeScore: Int, homeTeamId: String, homeTeamColor: String, poolId: String) {
        self.awayScore = awayScore
        self.awayTeamId = awayTeamId
        self.awayTeamColor = awayTeamColor
        self.boxNumber = boxNumber
        self.entryFee = entryFee
        self.entryId = entryId
        self.gameId = gameId
        self.homeScore = homeScore
        self.homeTeamId = homeTeamId
        self.homeTeamColor = homeTeamColor
        self.poolId = poolId
    }
    
    public class func newInstance(_ map: Map) -> Mappable? {
        return UserBidEntry()
    }
    public required init?(map: Map){}
    public override init(){}
    
    public func mapping(map: Map) {
        awayScore <- map["awayScore"]
        awayTeamId <- map["awayTeamId"]
        boxNumber <- map["boxNumber"]
        entryFee <- map["entryFee"]
        entryId <- map["entryId"]
        gameId <- map["gameId"]
        homeScore <- map["homeScore"]
        homeTeamId <- map["homeTeamId"]
        poolId <- map["poolId"]
    }
}

extension UserBidEntry {
    var awayHome: String {
        return "\(awayScore)-\(homeScore)"
    }
}
