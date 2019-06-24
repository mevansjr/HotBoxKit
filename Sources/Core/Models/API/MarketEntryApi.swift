//
//  MarketEntryApi.swift
//  HotBox
//
//  Created by Mark Evans on 3/19/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//

import Foundation

class MarketEntryApi : NSObject, Mappable {
    var marketplaceId : String?
    var awayScore : Int = 0
    var competitionId : String?
    var cancelledDateTimestamp : Double?
    var createdDateTimestamp : Double?
    var entryId : String?
    var gameId : String?
    var homeScore : Int = 0
    var isActive : Bool = false
    var marketplaceType : Int = 0
    var poolEntryFee : Int = 0
    var poolId : String?
    var price : Int = 0
    var sellerName : String?
    var sellerUserId : String?
    var buyerName : String?
    var buyerUserId : String?

    class func newInstance(_ map: Map) -> Mappable? {
        return MarketEntryApi()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map) {
        marketplaceId <- map["id"]
        awayScore <- map["awayScore"]
        competitionId <- map["competitionId"]
        cancelledDateTimestamp <- map["cancelledDateTimestamp"]
        createdDateTimestamp <- map["createdDateTimestamp"]
        entryId <- map["entryId"]
        gameId <- map["gameId"]
        homeScore <- map["homeScore"]
        isActive <- map["isActive"]
        marketplaceType <- map["marketplaceType"]
        poolEntryFee <- map["poolEntryFee"]
        poolId <- map["poolId"]
        price <- map["price"]
        sellerName <- map["sellerName"]
        sellerUserId <- map["sellerUserId"]
        buyerName <- map["buyerName"]
        buyerUserId <- map["buyerUserId"]
    }
}

extension MarketEntryApi {
    var boxNumber: Int {
        var box = 0
        if let entryId = self.entryId {
            let components = entryId.components(separatedBy: "_")
            var boxString = "\(box)"
            for value in components {
                if value.count <= 3 {
                    boxString = value
                    break
                }
            }
            if let boxValue = Int(boxString) {
                box = boxValue
            }
        }
        return box
    }
}
