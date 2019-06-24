//
//  OfferedEntry.swift
//  HotBox
//
//  Created by Erik Uecke on 5/22/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//

import Foundation

class OfferedEntry: NSObject, Mappable {
    var homeTeamId: String?
    var homeScore: Int?
    var gameId: String?
    var entryFee: Int?
    var boxNumber: Int?
    var poolId: String?
    var awayScore: Int?
    var awayTeamId: String?
    var entryId: String?
    
    class func newInstance(_ map: Map) -> Mappable? {
        return OfferedEntry()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map) {
        homeTeamId <- map["homeTeamId"]
        homeScore <- map["homeScore"]
        gameId <- map["gameId"]
        entryFee <- map["entryFee"]
        boxNumber <- map["boxNumber"]
        poolId <- map["poolId"]
        awayScore <- map["awayScore"]
        awayTeamId <- map["awayTeamId"]
        entryId <- map["entryId"]
    }
}
