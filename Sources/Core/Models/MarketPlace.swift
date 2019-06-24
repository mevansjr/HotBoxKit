//
//  MarketPlace.swift
//  HotBox
//
//  Created by Mark Evans on 3/20/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

struct MarketPlace {

    var id: String?
    var buyerName: String?
    var buyerUserId: String?
    var cancelledDateTimeUTC: Date?
    var competitionId: String?
    var createdDateTimeUTC: Date?
    var entryId: String?
    var gameId: String?
    var homeScore: Int = 0
    var awayScore: Int = 0
    var isActive: Bool = false
    var marketplaceType: Int = 0
    var poolEntryFee: Int = 0
    var poolId: String?
    var price: Int = 0
    var bidAmount: Int = 0
    var sellerName: String?
    var sellerUserId: String?
    var transactionDateTimeUTC: Date?
    var expireDateTimeUTC: Date
    var offeredEntries: [[String: Any]]?

    var representation: [String : Any] {
        var rep: [String : Any] = [
            "expireDateTimeUTC": expireDateTimeUTC,
            "homeScore": homeScore,
            "awayScore": awayScore,
            "isActive": isActive,
            "marketplaceType": marketplaceType,
            "poolEntryFee": poolEntryFee,
            "price": price,
            "bidAmount": bidAmount
            ]
        if let id = id {
            rep["id"] = id
        }
        if let offeredEntries = offeredEntries {
            rep["offeredEntries"] = offeredEntries
        }
        if let competitionId = competitionId {
            rep["competitionId"] = competitionId
        }
        if let buyerName = buyerName {
            rep["buyerName"] = buyerName
        }
        if let buyerUserId = buyerUserId {
            rep["buyerUserId"] = buyerUserId
        }
        if let entryId = entryId {
            rep["entryId"] = entryId
        }
        if let gameId = gameId {
            rep["gameId"] = gameId
        }
        if let poolId = poolId {
            rep["poolId"] = poolId
        }
        if let sellerName = sellerName {
            rep["sellerName"] = sellerName
        }
        if let sellerUserId = sellerUserId {
            rep["sellerUserId"] = sellerUserId
        }
        if let transactionDateTimeUTC = transactionDateTimeUTC {
            rep["transactionDateTimeUTC"] = transactionDateTimeUTC
        }
        if let cancelledDateTimeUTC = cancelledDateTimeUTC {
            rep["cancelledDateTimeUTC"] = cancelledDateTimeUTC
        }
        if let createdDateTimeUTC = createdDateTimeUTC {
            rep["createdDateTimeUTC"] = createdDateTimeUTC
        }
        return rep
    }

    init?(doc: DocumentSnapshot) {
        let data = doc.data()

        self.id = doc.documentID


        if let offeredEntries = data?["offeredEntries"] as? [[String: Any]] {
            self.offeredEntries = offeredEntries
        }

        self.bidAmount = 0
        if let bidAmount = data?["bidAmount"] as? Int {
            self.bidAmount = bidAmount
        }

        self.expireDateTimeUTC = Date()
        if let expireDateTimeUTC = data?["expireDateTimeUTC"] as? Timestamp {
            self.expireDateTimeUTC = Date(timeIntervalSince1970: TimeInterval(expireDateTimeUTC.seconds))
        }

        if let createdDateTimeUTC = data?["createdDateTimeUTC"] as? Timestamp {
            self.createdDateTimeUTC = Date(timeIntervalSince1970: TimeInterval(createdDateTimeUTC.seconds))
        }

        if let cancelledDateTimeUTC = data?["cancelledDateTimeUTC"] as? Timestamp {
            self.cancelledDateTimeUTC = Date(timeIntervalSince1970: TimeInterval(cancelledDateTimeUTC.seconds))
        }

        if let transactionDateTimeUTC = data?["transactionDateTimeUTC"] as? Timestamp {
            self.transactionDateTimeUTC = Date(timeIntervalSince1970: TimeInterval(transactionDateTimeUTC.seconds))
        }

        if let buyerName = data?["buyerName"] as? String {
            self.buyerName = buyerName
        }

        if let buyerUserId = data?["buyerUserId"] as? String {
            self.buyerUserId = buyerUserId
        }

        if let entryId = data?["entryId"] as? String {
            self.entryId = entryId
        }

        if let gameId = data?["gameId"] as? String {
            self.gameId = gameId
        }

        if let poolId = data?["poolId"] as? String {
            self.poolId = poolId
        }

        if let sellerName = data?["sellerName"] as? String {
            self.sellerName = sellerName
        }

        if let sellerUserId = data?["sellerUserId"] as? String {
            self.sellerUserId = sellerUserId
        }

        if let competitionId = data?["competitionId"] as? String {
            self.competitionId = competitionId
        }

        self.homeScore = data?["homeScore"] as? Int ?? 0
        self.awayScore = data?["awayScore"] as? Int ?? 0
        self.isActive = data?["isActive"] as? Bool ?? false
        self.marketplaceType = data?["marketplaceType"] as? Int ?? 0
        self.poolEntryFee = data?["poolEntryFee"] as? Int ?? 0
        self.price = data?["price"] as? Int ?? 0

        return nil
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data(with: ServerTimestampBehavior.estimate)

        self.id = document.documentID

        if let offeredEntries = data["offeredEntries"] as? [[String: Any]] {
            self.offeredEntries = offeredEntries
        }

        self.bidAmount = 0
        if let bidAmount = data["bidAmount"] as? Int {
            self.bidAmount = bidAmount
        }

        self.expireDateTimeUTC = Date()
        if let expireDateTimeUTC = data["expireDateTimeUTC"] as? Timestamp {
            self.expireDateTimeUTC = Date(timeIntervalSince1970: TimeInterval(expireDateTimeUTC.seconds))
        }

        if let createdDateTimeUTC = data["createdDateTimeUTC"] as? Timestamp {
            self.createdDateTimeUTC = Date(timeIntervalSince1970: TimeInterval(createdDateTimeUTC.seconds))
        }

        if let cancelledDateTimeUTC = data["cancelledDateTimeUTC"] as? Timestamp {
            self.cancelledDateTimeUTC = Date(timeIntervalSince1970: TimeInterval(cancelledDateTimeUTC.seconds))
        }

        if let transactionDateTimeUTC = data["transactionDateTimeUTC"] as? Timestamp {
            self.transactionDateTimeUTC = Date(timeIntervalSince1970: TimeInterval(transactionDateTimeUTC.seconds))
        }

        if let buyerName = data["buyerName"] as? String {
            self.buyerName = buyerName
        }

        if let buyerUserId = data["buyerUserId"] as? String {
            self.buyerUserId = buyerUserId
        }

        if let entryId = data["entryId"] as? String {
            self.entryId = entryId
        }

        if let gameId = data["gameId"] as? String {
            self.gameId = gameId
        }

        if let poolId = data["poolId"] as? String {
            self.poolId = poolId
        }

        if let sellerName = data["sellerName"] as? String {
            self.sellerName = sellerName
        }

        if let sellerUserId = data["sellerUserId"] as? String {
            self.sellerUserId = sellerUserId
        }

        if let competitionId = data["competitionId"] as? String {
            self.competitionId = competitionId
        }

        self.homeScore = data["homeScore"] as? Int ?? 0
        self.awayScore = data["awayScore"] as? Int ?? 0
        self.isActive = data["isActive"] as? Bool ?? false
        self.marketplaceType = data["marketplaceType"] as? Int ?? 0
        self.poolEntryFee = data["poolEntryFee"] as? Int ?? 0
        self.price = data["price"] as? Int ?? 0
    }
}

extension MarketPlace: Comparable {
    static func == (lhs: MarketPlace, rhs: MarketPlace) -> Bool {
        return lhs.createdDateTimeUTC == rhs.createdDateTimeUTC
    }

    static func < (lhs: MarketPlace, rhs: MarketPlace) -> Bool {
        return lhs.createdDateTimeUTC != nil && rhs.createdDateTimeUTC != nil && lhs.createdDateTimeUTC! < rhs.createdDateTimeUTC!
    }
}

extension MarketPlace {
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
    
    static func getMarketPlaceItems(completion: @escaping CompletionHandler) {
        let reference = Constants.shared.db.collection("marketplace")
        reference
            .whereField("expireDateTimeUTC", isGreaterThan: Date())
            .whereField("isActive", isEqualTo: true)
            .getDocuments(completion: { (querySnap, error) in
            guard let querySnap = querySnap else {
                DispatchQueue.main.async {
                    completion(nil, NSError(domain: "\(error?.localizedDescription ?? "No error")", code: 400, userInfo: nil))
                }
                return
            }
            var marketPlaceItems = [MarketPlace]()
            querySnap.documents.forEach({ (doc) in
                if let market = MarketPlace(document: doc) {
                    marketPlaceItems.append(market)
                }
            })
            DispatchQueue.main.async {
                let marketItems = marketPlaceItems.sorted()
                completion(marketItems, nil)
            }
        })
    }

    func gameStatus(games: [Game]) -> Int {
        if let game = games.filter({$0.id == self.gameId}).first {
            return game.status
        }
        return 2
    }
}

extension MarketPlace {
    var awayHome: String {
        return "\(awayScore)-\(homeScore)"
    }

    var box: Int? {
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

    var sellerNameDescription: String {
        if let sellerName = self.sellerName {
            let set = sellerName.components(separatedBy: " ")
            if set.count > 1 {
                var firstName = ""
                var lastName = ""
                set.forEach { (s) in
                    if s == " " {
                    }
                    else {
                        if firstName.isEmpty {
                            firstName = s.trimmingCharacters(in: .whitespaces)
                        }
                        else if lastName.isEmpty {
                            lastName = s.trimmingCharacters(in: .whitespaces)
                        }
                    }
                }
                if let firstCharacter = firstName.first {
                    return "\(String(firstCharacter)). \(lastName)"
                }
            }
            return sellerName
        }
        return self.sellerName ?? ""
    }

    var buyerNameDescription: String {
        if let buyerName = self.buyerName {
            let set = buyerName.components(separatedBy: " ")
            if set.count > 1 {
                var firstName = ""
                var lastName = ""
                set.forEach { (s) in
                    if s == " " {
                    }
                    else {
                        if firstName.isEmpty {
                            firstName = s.trimmingCharacters(in: .whitespaces)
                        }
                        else if lastName.isEmpty {
                            lastName = s.trimmingCharacters(in: .whitespaces)
                        }
                    }
                }
                if let firstCharacter = firstName.first {
                    return "\(String(firstCharacter)). \(lastName)"
                }
            }
            return buyerName
        }
        return self.buyerName ?? ""
    }
}
