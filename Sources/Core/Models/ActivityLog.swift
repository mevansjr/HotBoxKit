//
//  ActivityLog.swift
//  HotBox
//
//  Created by Mark Evans on 3/26/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

struct ActivityLog {

    var id: String?
    var awayScore: Int?
    var awayTeamId: String?
    var boxNumber: Int?
    var categoryDescription: String?
    var competitionId: String?
    var created: Date?
    var deepLink: String?
    var entryId: String?
    var gameDate: Date?
    var gameId: String?
    var homeScore: Int?
    var majorCategoryId: Int?
    var marketplaceId: String?
    var minorCategoryId: Int?
    var poolEntryFee: Int?
    var poolId: String?
    var salePrice: Int?
    var userId: String?
    var userName: String?
    var bidAmount: Int?
    var transactionAmount: Int?
    var transactionBalance: Int?
    var offeredEntries: [[String: Any]]?

    var representation: [String : Any] {
        var rep: [String : Any] = [:]
        if let id = id {
            rep["id"] = id
        }
        if let offeredEntries = offeredEntries {
            rep["offeredEntries"] = offeredEntries
        }
        if let awayScore = awayScore {
            rep["awayScore"] = awayScore
        }
        if let awayTeamId = awayTeamId {
            rep["awayTeamId"] = awayTeamId
        }
        if let boxNumber = boxNumber {
            rep["boxNumber"] = boxNumber
        }
        if let categoryDescription = categoryDescription {
            rep["categoryDescription"] = categoryDescription
        }
        if let competitionId = competitionId {
            rep["competitionId"] = competitionId
        }
        if let created = created {
            rep["created"] = created
        }
        if let deepLink = deepLink {
            rep["deepLink"] = deepLink
        }
        if let entryId = entryId {
            rep["entryId"] = entryId
        }
        if let gameDate = gameDate {
            rep["gameDate"] = gameDate
        }
        if let gameId = gameId {
            rep["gameId"] = gameId
        }
        if let homeScore = homeScore {
            rep["homeScore"] = homeScore
        }
        if let majorCategoryId = majorCategoryId {
            rep["majorCategoryId"] = majorCategoryId
        }
        if let minorCategoryId = minorCategoryId {
            rep["minorCategoryId"] = minorCategoryId
        }
        if let poolEntryFee = poolEntryFee {
            rep["poolEntryFee"] = poolEntryFee
        }
        if let poolId = poolId {
            rep["poolId"] = poolId
        }
        if let salePrice = salePrice {
            rep["salePrice"] = salePrice
        }
        if let userId = userId {
            rep["userId"] = userId
        }
        if let userName = userName {
            rep["userName"] = userName
        }
        if let bidAmount = bidAmount {
            rep["bidAmount"] = bidAmount
        }
        if let transactionAmount = transactionAmount {
            rep["transactionAmount"] = transactionAmount
        }
        if let transactionBalance = transactionBalance {
            rep["transactionBalance"] = transactionBalance
        }
        if let marketplaceId = marketplaceId {
            rep["marketplaceId"] = marketplaceId
        }
        return rep
    }

    init?(doc: DocumentSnapshot) {
        let data = doc.data()

        self.id = doc.documentID

        if let offeredEntries = data?["offeredEntries"] as? [[String: Any]] {
            self.offeredEntries = offeredEntries
        }
        if let awayScore = data?["awayScore"] as? Int {
            self.awayScore = awayScore
        }
        if let awayTeamId = data?["awayTeamId"] as? String {
            self.awayTeamId = awayTeamId
        }
        if let boxNumber = data?["boxNumber"] as? Int {
            self.boxNumber = boxNumber
        }
        if let categoryDescription = data?["categoryDescription"] as? String {
            self.categoryDescription = categoryDescription
        }
        if let competitionId = data?["competitionId"] as? String {
            self.competitionId = competitionId
        }
        if let created = data?["created"] as? Timestamp {
            self.created = Date(timeIntervalSince1970: Double(created.seconds))
        }
        if let deepLink = data?["deepLink"] as? String {
            self.deepLink = deepLink
        }
        if let entryId = data?["entryId"] as? String {
            self.entryId = entryId
        }
        if let gameDate = data?["gameDate"] as? Timestamp {
            self.gameDate = Date(timeIntervalSince1970: Double(gameDate.seconds))
        }
        if let gameId = data?["gameId"] as? String {
            self.gameId = gameId
        }
        if let homeScore = data?["homeScore"] as? Int {
            self.homeScore = homeScore
        }
        if let majorCategoryId = data?["majorCategoryId"] as? Int {
            self.majorCategoryId = majorCategoryId
        }
        if let minorCategoryId = data?["minorCategoryId"] as? Int {
            self.minorCategoryId = minorCategoryId
        }
        if let poolEntryFee = data?["poolEntryFee"] as? Int {
            self.poolEntryFee = poolEntryFee
        }
        if let poolId = data?["poolId"] as? String {
            self.poolId = poolId
        }
        if let salePrice = data?["salePrice"] as? Int {
            self.salePrice = salePrice
        }
        if let userId = data?["userId"] as? String {
            self.userId = userId
        }
        if let userName = data?["userName"] as? String {
            self.userName = userName
        }
        if let bidAmount = data?["bidAmount"] as? Int {
            self.bidAmount = bidAmount
        }
        if let transactionBalance = data?["transactionBalance"] as? Int {
            self.transactionBalance = transactionBalance
        }
        if let transactionAmount = data?["transactionAmount"] as? Int {
            self.transactionAmount = transactionAmount
        }
        if let marketplaceId = data?["marketplaceId"] as? String {
            self.marketplaceId = marketplaceId
        }
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()

        self.id = document.documentID

        if let offeredEntries = data["offeredEntries"] as? [[String: Any]] {
            self.offeredEntries = offeredEntries
        }
        if let awayScore = data["awayScore"] as? Int {
            self.awayScore = awayScore
        }
        if let awayTeamId = data["awayTeamId"] as? String {
            self.awayTeamId = awayTeamId
        }
        if let boxNumber = data["boxNumber"] as? Int {
            self.boxNumber = boxNumber
        }
        if let categoryDescription = data["categoryDescription"] as? String {
            self.categoryDescription = categoryDescription
        }
        if let competitionId = data["competitionId"] as? String {
            self.competitionId = competitionId
        }
        if let created = data["created"] as? Timestamp {
            self.created = Date(timeIntervalSince1970: Double(created.seconds))
        }
        if let deepLink = data["deepLink"] as? String {
            self.deepLink = deepLink
        }
        if let entryId = data["entryId"] as? String {
            self.entryId = entryId
        }
        if let gameDate = data["gameDate"] as? Timestamp {
            self.gameDate = Date(timeIntervalSince1970: Double(gameDate.seconds))
        }
        if let gameId = data["gameId"] as? String {
            self.gameId = gameId
        }
        if let homeScore = data["homeScore"] as? Int {
            self.homeScore = homeScore
        }
        if let majorCategoryId = data["majorCategoryId"] as? Int {
            self.majorCategoryId = majorCategoryId
        }
        if let minorCategoryId = data["minorCategoryId"] as? Int {
            self.minorCategoryId = minorCategoryId
        }
        if let poolEntryFee = data["poolEntryFee"] as? Int {
            self.poolEntryFee = poolEntryFee
        }
        if let poolId = data["poolId"] as? String {
            self.poolId = poolId
        }
        if let salePrice = data["salePrice"] as? Int {
            self.salePrice = salePrice
        }
        if let userId = data["userId"] as? String {
            self.userId = userId
        }
        if let userName = data["userName"] as? String {
            self.userName = userName
        }
        if let bidAmount = data["bidAmount"] as? Int {
            self.bidAmount = bidAmount
        }
        if let transactionBalance = data["transactionBalance"] as? Int {
            self.transactionBalance = transactionBalance
        }
        if let transactionAmount = data["transactionAmount"] as? Int {
            self.transactionAmount = transactionAmount
        }
        if let marketplaceId = data["marketplaceId"] as? String {
            self.marketplaceId = marketplaceId
        }
    }
}

extension ActivityLog: Comparable {
    static func == (lhs: ActivityLog, rhs: ActivityLog) -> Bool {
        return lhs.created == rhs.created
    }

    static func < (lhs: ActivityLog, rhs: ActivityLog) -> Bool {
        return lhs.created != nil && rhs.created != nil && lhs.created! > rhs.created!
    }
}

extension ActivityLog {
    var offeredTrades: [UserBidEntry] {
        var offers = [UserBidEntry]()
        if let trades = self.offeredEntries {
            trades.forEach { (object) in
                let trade = UserBidEntry()
                trade.poolId = object["poolId"] as? String
                trade.awayScore = object["awayScore"] as? Int ?? 0
                trade.homeScore = object["homeScore"] as? Int ?? 0
                trade.gameId = object["gameId"] as? String
                trade.homeTeamId = object["homeTeamId"] as? String
                trade.awayTeamId = object["awayTeamId"] as? String
                trade.boxNumber = object["boxNumber"] as? Int
                trade.entryFee = object["entryFee"] as? Int ?? 0
                trade.entryId = object["entryId"] as? String
                offers.append(trade)
            }
        }
        return offers
    }

    var title: String {
        guard let major = self.majorCategoryId else {
            return ""
        }
        guard let minor = self.minorCategoryId else {
            return ""
        }
        switch major {
        case 1: // User
            switch minor {
            case 0:
                return "User registered"
            default:
                return ""
            }
        case 2: // Marketplace
            switch minor {
            case 0:
                return "You purchased box (\(self.boxNumber ?? 0))"
            case 1:
                return "You listed box (\(self.boxNumber ?? 0)) for sale"
            case 2:
                return "You offered \(self.bidAmount?.currency(digits: 0) ?? "$0") for bid selection [\(self.awayScore ?? 0)-\(self.homeScore ?? 0)]"
            case 3:
                return "You sold box (\(self.boxNumber ?? 0))"
            case 4:
                return "You purchased for sale box (\(self.boxNumber ?? 0))"
            case 5:
                return "You accepted a bid offer for selection [\(self.awayScore ?? 0)-\(self.homeScore ?? 0)]"
            case 6:
                return "You won bid [\(self.awayScore ?? 0)-\(self.homeScore ?? 0)]"
            case 7:
                return "Bid offer for selection [\(self.awayScore ?? 0)-\(self.homeScore ?? 0)]"
            default:
                return ""
            }
        case 3: // Transaction
            switch minor {
            case 0:
                return "\(self.transactionAmount?.currency(digits: 0) ?? "$0") was added. Balance: \(self.transactionBalance?.currency(digits: 0) ?? "$0")"
            case 1:
                return "\(self.transactionAmount?.currency(digits: 0) ?? "$0") was withdrawn. Balance: \(self.transactionBalance?.currency(digits: 0) ?? "$0")"
            default:
                return ""
            }
        default:

            return ""
        }
    }

    var actionStatus: (BidUI, Bool, Bool) {
        guard let major = self.majorCategoryId else {
            return (BidUI.unknown, false, false)
        }
        guard let minor = self.minorCategoryId else {
            return (BidUI.unknown, false, false)
        }
        switch major {
        case 1: // User
            switch minor {
            case 0:
                return (BidUI.unknown, false, false)
            default:
                return (BidUI.unknown, false, false)
            }
        case 2: // Marketplace
            switch minor {
            case 0:
                return (BidUI.unknown, false, false)
            case 1:
                return (BidUI.unknown, false, false)
            case 2:
                return (BidUI.outgoing, true, false)
            case 3:
                return (BidUI.unknown, false, false)
            case 4:
                return (BidUI.unknown, false, false)
            case 5:
                return (BidUI.unknown, false, false)
            case 6:
                return (BidUI.unknown, false, false)
            case 7:
                return (BidUI.incoming, true, true)
            default:
                return (BidUI.unknown, false, false)
            }
        case 3: // Transaction
            switch minor {
            case 0:
                return (BidUI.unknown, false, false)
            case 1:
                return (BidUI.unknown, false, false)
            default:
                return (BidUI.unknown, false, false)
            }
        default:
            return (BidUI.unknown, false, false)
        }
    }

    func isOutgoingBidCancelled(marketplaceItems: [MarketPlace]) -> Bool {
        let bidType = self.actionStatus.0
        if bidType == .outgoing {
            let marketItems = marketplaceItems.sorted()
            if let market = marketItems.filter({$0.id == self.marketplaceId}).first {
                return !market.isActive
            }
        }
        return true
    }

    func isIncomingBidCancelled(marketplaceItems: [MarketPlace]) -> Bool {
        let bidType = self.actionStatus.0
        if bidType == .incoming {
            let liveEntries = ClientService.shared.livePools.flatMap({$0.arrayOfEntries}).map({$0.id!})
            let upcomingEntries = ClientService.shared.upcomingPools.flatMap({$0.arrayOfEntries}).map({$0.id!})
            let allEntries = liveEntries+upcomingEntries
            if let entryId = self.entryId, allEntries.contains(entryId) {
                let marketItems = marketplaceItems.sorted()
                if let market = marketItems.filter({$0.id == self.marketplaceId}).first {
                    return !market.isActive
                }
            }
        }
        return true
    }

    static func logs(userId: String, completion: @escaping CompletionHandler) {
        let _ = Constants.shared.db.collection("activityLogs")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { (snapshot, error) in
                guard let snapshot = snapshot else {
                    DispatchQueue.main.async {
                        completion([ActivityLog](), nil)
                    }
                    return
                }
                var activityLogs = [ActivityLog]()
                snapshot.documents.forEach({ (snap) in
                    if let activityLog = ActivityLog(document: snap) {
                        activityLogs.append(activityLog)
                    }
                })
                activityLogs = activityLogs.sorted()
                DispatchQueue.main.async {
                    completion(activityLogs, nil)
                }
        }
    }
}
