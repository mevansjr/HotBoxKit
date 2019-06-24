//
//  ActivityLogAPI.swift
//  HotBox
//
//  Created by Erik Uecke on 5/22/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//

import Foundation

class ActivityLogApi : NSObject, Mappable {
    var id: String?
    var createdDateTimeStamp: Double?
    var majorCategoryId: Int?
    var minorCategoryId: Int?
    var awayScore: Int?
    var awayTeamId: String?
    var bidAmount: Int?
    var bidExpireDate: Double?
    var boxNumber: Int?
    var competitionId: String?
    var deepLink: String?
    var entryId: String?
    var gameDate: Double?
    var gameId: String?
    var homeScore: Int?
    var homeTeamId: String?
    var marketplaceId: String?
    var offeredEntries: [OfferedEntry]?
    var poolEntryFee: Int?
    var poolId: String?
    var transactionDate: Double?
    var transactionId: String?
    var transactionAmount: Int?
    var transactionBalance: Int?
    var transactionType: Int?
    var userId: String?
    var userName: String?
    
    class func newInstance(_ map: Map) -> Mappable? {
        return ActivityLogApi()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map) {
        
        id <- map["id"]
        createdDateTimeStamp <- map["createdDateTimeStamp"]
        majorCategoryId <- map["majorCategoryId"]
        minorCategoryId <- map["minorCategoryId"]
        awayScore <- map["awayScore"]
        awayTeamId <- map["awayTeamId"]
        bidAmount <- map["bidAmount"]
        bidExpireDate <- map["bidExpireDate"]
        boxNumber <- map["boxNumber"]
        competitionId <- map["competitionId"]
        deepLink <- map["deepLink"]
        entryId <- map["entryId"]
        gameDate <- map["gameDate"]
        gameId <- map["gameId"]
        homeScore <- map["homeScore"]
        homeTeamId <- map["homeTeamId"]
        marketplaceId <- map["marketplaceId"]
        offeredEntries <- map["offeredEntries"]
        poolEntryFee <- map["poolEntryFee"]
        poolId <- map["poolId"]
        transactionDate <- map["transactionDate"]
        transactionId <- map["transactionId"]
        transactionAmount <- map["transactionAmount"]
        transactionBalance <- map["transactionBalance"]
        transactionType <- map["transactionType"]
        userId <- map["userId"]
        userName <- map["userName"]
    }
}

//extension ActivityLogApi {
//    
//    var offeredTrades: [UserBidEntry] {
//        var offers = [UserBidEntry]()
//        if let trades = self.offeredEntries {
//            trades.forEach { (offeredEntry) in
//                let trade = UserBidEntry()
//                trade.poolId = offeredEntry.poolId
//                trade.awayScore = offeredEntry.awayScore ?? 0
//                trade.homeScore = offeredEntry.homeScore ?? 0
//                trade.gameId = offeredEntry.gameId
//                trade.homeTeamId = offeredEntry.homeTeamId
//                trade.awayTeamId = offeredEntry.awayTeamId
//                trade.boxNumber = offeredEntry.boxNumber
//                trade.entryFee = offeredEntry.entryFee ?? 0
//                trade.entryId = offeredEntry.entryId
//                offers.append(trade)
//            }
//        }
//        return offers
//    }
//    
//    var title: String {
//        guard let major = self.majorCategoryId else {
//            return ""
//        }
//        guard let minor = self.minorCategoryId else {
//            return ""
//        }
//        switch major {
//        case 1: // User
//            switch minor {
//            case 0:
//                return "User registered"
//            default:
//                return ""
//            }
//        case 2: // Marketplace
//            switch minor {
//            case 0:
//                return "You purchased box (\(self.boxNumber ?? 0))"
//            case 1:
//                return "You listed box (\(self.boxNumber ?? 0)) for sale"
//            case 2:
//                return "You offered \(self.bidAmount?.currency(digits: 0) ?? "$0") for bid selection [\(self.awayScore ?? 0)-\(self.homeScore ?? 0)]"
//            case 3:
//                return "You sold box (\(self.boxNumber ?? 0))"
//            case 4:
//                return "You purchased for sale box (\(self.boxNumber ?? 0))"
//            case 5:
//                return "You accepted a bid offer for selection [\(self.awayScore ?? 0)-\(self.homeScore ?? 0)]"
//            case 6:
//                return "You won bid [\(self.awayScore ?? 0)-\(self.homeScore ?? 0)]"
//            case 7:
//                return "Bid offer for selection [\(self.awayScore ?? 0)-\(self.homeScore ?? 0)]"
//            default:
//                return ""
//            }
//        case 3: // Transaction
//            switch minor {
//            case 0:
//                return "\(self.transactionAmount?.currency(digits: 0) ?? "$0") was added. Balance: \(self.transactionBalance?.currency(digits: 0) ?? "$0")"
//            case 1:
//                return "\(self.transactionAmount?.currency(digits: 0) ?? "$0") was withdrawn. Balance: \(self.transactionBalance?.currency(digits: 0) ?? "$0")"
//            default:
//                return ""
//            }
//        default:
//            
//            return ""
//        }
//    }
//    
//    var actionStatus: (BidUI, Bool, Bool) {
//        guard let major = self.majorCategoryId else {
//            return (BidUI.unknown, false, false)
//        }
//        guard let minor = self.minorCategoryId else {
//            return (BidUI.unknown, false, false)
//        }
//        switch major {
//        case 1: // User
//            switch minor {
//            case 0:
//                return (BidUI.unknown, false, false)
//            default:
//                return (BidUI.unknown, false, false)
//            }
//        case 2: // Marketplace
//            switch minor {
//            case 0:
//                return (BidUI.unknown, false, false)
//            case 1:
//                return (BidUI.unknown, false, false)
//            case 2:
//                return (BidUI.outgoing, true, false)
//            case 3:
//                return (BidUI.unknown, false, false)
//            case 4:
//                return (BidUI.unknown, false, false)
//            case 5:
//                return (BidUI.unknown, false, false)
//            case 6:
//                return (BidUI.unknown, false, false)
//            case 7:
//                return (BidUI.incoming, true, true)
//            default:
//                return (BidUI.unknown, false, false)
//            }
//        case 3: // Transaction
//            switch minor {
//            case 0:
//                return (BidUI.unknown, false, false)
//            case 1:
//                return (BidUI.unknown, false, false)
//            default:
//                return (BidUI.unknown, false, false)
//            }
//        default:
//            return (BidUI.unknown, false, false)
//        }
//    }
//    
//    func isIncomingBidCancelled(marketplaceItems: [MarketPlace]) -> Bool {
//        let bidType = self.actionStatus.0
//        if bidType == .incoming {
//            let liveEntries = ClientService.shared.livePools.flatMap({$0.arrayOfEntries}).map({$0.id!})
//            let upcomingEntries = ClientService.shared.upcomingPools.flatMap({$0.arrayOfEntries}).map({$0.id!})
//            let allEntries = liveEntries+upcomingEntries
//            if let entryId = self.entryId, allEntries.contains(entryId) {
//                let marketItems = marketplaceItems.sorted()
//                if let market = marketItems.filter({$0.id == self.marketplaceId}).first {
//                    return !market.isActive
//                }
//            }
//        }
//        return true
//    }
//    
//    func isOutgoingBidCancelled(marketplaceItems: [MarketPlace]) -> Bool {
//        let bidType = self.actionStatus.0
//        if bidType == .outgoing {
//            let marketItems = marketplaceItems.sorted()
//            if let market = marketItems.filter({$0.id == self.marketplaceId}).first {
//                return !market.isActive
//            }
//        }
//        return true
//    }
//}

