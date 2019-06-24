//
//  Pool.swift
//  HotBox
//
//  Created by Mark Evans on 12/4/18.
//  Copyright © 2018 Mark Evans. All rights reserved.
//

import Foundation

struct Pool {

    var id: String?
    var awayScoringIndex: [Int]
    var homeScoringIndex: [Int]
    var entryFee: Int
    var gameId: String
    var userId: String?
    var entryUserIds: [String]?
    var name: String
    var status: Int = 0
    var entriesDisplayData: [String: Any]?
    var prizes: [[String: Any]]?
    var totalNumEntries = 0

    var representation: [String : Any] {
        var rep: [String : Any] = [
            "awayScoringIndex": awayScoringIndex,
            "homeScoringIndex": homeScoringIndex,
            "entryFee": entryFee,
            "gameId": gameId,
            "name": name,
            "totalNumEntries": totalNumEntries,
            "status": status
        ]
        if let id = id {
            rep["id"] = id
        }
        if let userId = userId {
            rep["userId"] = userId
        }
        if let entryUserIds = entryUserIds {
            rep["entryUserIds"] = entryUserIds
        }
        if let entriesDisplayData = entriesDisplayData {
            rep["entriesDisplayData"] = entriesDisplayData
        }
        if let prizes = prizes {
            rep["prizes"] = prizes
        }
        return rep
    }

    init(awayScoringIndex: [Int], homeScoringIndex: [Int], entryFee: Int, gameId: String, userId: String?, name: String, status: Int) {
        self.id = nil
        self.prizes = nil
        self.prizes = nil
        self.awayScoringIndex = awayScoringIndex
        self.homeScoringIndex = homeScoringIndex
        self.entryFee = entryFee
        self.gameId = gameId
        if let usrId = userId {
            self.userId = usrId
        }
        else {
            self.userId = nil
        }
        self.entryUserIds = nil
        self.name = name
        self.status = status
        self.totalNumEntries = 0
    }

    init?(doc: DocumentSnapshot?) {
        let data = doc?.data()

        self.id = doc?.documentID

        if let totalNumEntries = data?["totalNumEntries"] as? Int {
            self.totalNumEntries = totalNumEntries
        }
        else {
            self.totalNumEntries = 0
        }

        if let entryUserIds = data?["entryUserIds"] as? [String] {
            self.entryUserIds = entryUserIds
        }

        if let entriesDisplayData = data?["entriesDisplayData"] as? [String: Any] {
            self.entriesDisplayData = entriesDisplayData
        }

        if let prizes = data?["prizes"] as? [[String: Any]] {
            self.prizes = prizes
        }

        guard let awayScoringIndex = data?["awayScoringIndex"] as? [Int] else {
            return nil
        }

        guard let homeScoringIndex = data?["homeScoringIndex"] as? [Int] else {
            return nil
        }

        guard let entryFee = data?["entryFee"] as? Int else {
            return nil
        }

        guard let gameId = data?["gameId"] as? String else {
            return nil
        }

        if let userId = data?["userId"] as? String {
            self.userId = userId
        }

        guard let name = data?["name"] as? String else {
            return nil
        }

        guard let status = data?["status"] as? Int else {
            return nil
        }

        self.awayScoringIndex = awayScoringIndex
        self.homeScoringIndex = homeScoringIndex
        self.entryFee = entryFee
        self.gameId = gameId
        self.name = name
        self.status = status
    }

    init?(doc: DocumentSnapshot) {
        let data = doc.data()

        self.id = doc.documentID

        if let totalNumEntries = data?["totalNumEntries"] as? Int {
            self.totalNumEntries = totalNumEntries
        }
        else {
            self.totalNumEntries = 0
        }

        if let entryUserIds = data?["entryUserIds"] as? [String] {
            self.entryUserIds = entryUserIds
        }

        if let entriesDisplayData = data?["entriesDisplayData"] as? [String: Any] {
            self.entriesDisplayData = entriesDisplayData
        }

        if let prizes = data?["prizes"] as? [[String: Any]] {
            self.prizes = prizes
        }

        guard let awayScoringIndex = data?["awayScoringIndex"] as? [Int] else {
            return nil
        }

        guard let homeScoringIndex = data?["homeScoringIndex"] as? [Int] else {
            return nil
        }

        guard let entryFee = data?["entryFee"] as? Int else {
            return nil
        }

        guard let gameId = data?["gameId"] as? String else {
            return nil
        }

        if let userId = data?["userId"] as? String {
            self.userId = userId
        }

        guard let name = data?["name"] as? String else {
            return nil
        }

        guard let status = data?["status"] as? Int else {
            return nil
        }

        self.awayScoringIndex = awayScoringIndex
        self.homeScoringIndex = homeScoringIndex
        self.entryFee = entryFee
        self.gameId = gameId
        self.name = name
        self.status = status
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()

        self.id = document.documentID

        if let totalNumEntries = data["totalNumEntries"] as? Int {
            self.totalNumEntries = totalNumEntries
        }
        else {
            self.totalNumEntries = 0
        }

        if let entryUserIds = data["entryUserIds"] as? [String] {
            self.entryUserIds = entryUserIds
        }

        if let entriesDisplayData = data["entriesDisplayData"] as? [String: Any] {
            self.entriesDisplayData = entriesDisplayData
        }

        if let prizes = data["prizes"] as? [[String: Any]] {
            self.prizes = prizes
        }

        guard let awayScoringIndex = data["awayScoringIndex"] as? [Int] else {
            return nil
        }

        guard let homeScoringIndex = data["homeScoringIndex"] as? [Int] else {
            return nil
        }

        guard let entryFee = data["entryFee"] as? Int else {
            return nil
        }

        guard let gameId = data["gameId"] as? String else {
            return nil
        }

        if let userId = data["userId"] as? String {
            self.userId = userId
        }

        guard let name = data["name"] as? String else {
            return nil
        }

        guard let status = data["status"] as? Int else {
            return nil
        }

        self.awayScoringIndex = awayScoringIndex
        self.homeScoringIndex = homeScoringIndex
        self.entryFee = entryFee
        self.gameId = gameId
        self.name = name
        self.status = status
    }
}

extension Pool: Comparable {
    static func == (lhs: Pool, rhs: Pool) -> Bool {
        return lhs.name == rhs.name
    }

    static func < (lhs: Pool, rhs: Pool) -> Bool {
        return lhs.name < rhs.name
    }
}

extension Pool {
//    var poolPrizes: [Prize] {
//        var allPrizes = [Prize]()
//        if let mapPrizes = self.prizes {
//            mapPrizes.forEach { (dict) in
//                if
//                    let amount = dict["amount"] as? Int,
//                    let name = dict["name"] as? String,
//                    let sortOrder = dict["sortOrder"] as? Int,
//                    let userId = dict["userId"] as? String?,
//                    let entryId = dict["entryId"] as? String?,
//                    let boxNumber = dict["boxNumber"] as? Int?,
//                    let userName = dict["userName"] as? String?,
//                    let rake = dict["rake"] as? Int?,
//                    let prizeAmount = dict["prizeAmount"] as? Int?
//                {
//                    let prize = Prize(amount: amount, name: name, sortOrder: sortOrder, userId: userId, entryId: entryId, boxNumber: boxNumber, userName: userName, rake: rake, prizeAmount: prizeAmount)
//                    allPrizes.append(prize)
//                }
//            }
//        }
//        allPrizes = allPrizes.sorted(by: {$0.sortOrder != nil && $1.sortOrder != nil && $0.sortOrder! < $1.sortOrder!})
//        return allPrizes
//    }
//
//    var entries: [Entry] {
//        var allEntries = [Entry]()
//        if let mapEntries = self.entriesDisplayData {
//            mapEntries.forEach { (_, value) in
//                if let dict = value as? [String: Any] {
//                    if
//                        let boxNumber = dict["boxNumber"],
//                        let userId = dict["userId"] as? String,
//                        let name = dict["name"] as? String,
//                        let entryId = dict["entryId"] as? String,
//                        let awayScore = dict["awayScore"] as? Int,
//                        let homeScore = dict["homeScore"] as? Int
//                    {
//                        var correct = 0
//                        if let boxNumber = boxNumber as? Int {
//                            correct = boxNumber
//                        }
//                        else if let boxNumber = boxNumber as? String, let correctedBoxNumber = Int(boxNumber) {
//                            correct = correctedBoxNumber
//                        }
//                        let entry = Entry(entryId: entryId, boxNumber: correct, entryFee: self.entryFee, userId: userId, name: name, isForSale: nil, salePrice: nil, status: 1, awayScore: awayScore, homeScore: homeScore)
//                        allEntries.append(entry)
//                    }
//                }
//            }
//        }
//        allEntries = allEntries.sorted(by: {$0.boxNumber < $1.boxNumber})
//        return allEntries
//    }
//
//    static func pool(poolId: String, completion: @escaping CompletionHandler) {
//        let _ = Constants.shared.db.collection("pools").document(poolId).addSnapshotListener { (snapshot, error) in
//            guard let snapshot = snapshot else {
//                DispatchQueue.main.async {
//                    completion(nil, NSError(domain: "\(error?.localizedDescription ?? "No error")", code: 400, userInfo: nil))
//                }
//                return
//            }
//            if let pool = Pool(doc: snapshot) {
//                DispatchQueue.main.async {
//                    completion(pool, nil)
//                }
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
//            }
//        }
//    }
//
//    static func gameAndPool(poolId: String, completion: @escaping CompletionHandler) {
//        Pool.pool(poolId: poolId) { (success, err) in
//            if let pool = success as? Pool {
//                let _ = Constants.shared.db.collection("games").document(pool.gameId).addSnapshotListener { (snapshot, error) in
//                    guard let snapshot = snapshot else {
//                        DispatchQueue.main.async {
//                            completion(nil, NSError(domain: "\(error?.localizedDescription ?? "No error")", code: 400, userInfo: nil))
//                        }
//                        return
//                    }
//                    if let game = Game(doc: snapshot) {
//                        DispatchQueue.main.async {
//                            completion((game, pool), nil)
//                        }
//                        return
//                    }
//                    DispatchQueue.main.async {
//                        completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
//                    }
//                }
//                return
//            }
//            else if let e = err {
//                DispatchQueue.main.async {
//                    completion(nil, e)
//                }
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
//            }
//        }
//    }
//
//    static func entryCount(poolId: String, completion: @escaping CompletionHandler) {
//        let _ = Constants.shared.db.collection("entries")
//            .whereField("poolId", isEqualTo: poolId)
//            .addSnapshotListener { (snapshot, error) in
//            guard let snapshot = snapshot else {
//                DispatchQueue.main.async {
//                    completion(0, nil)
//                }
//                return
//            }
//            DispatchQueue.main.async {
//                completion(snapshot.documents.count, nil)
//            }
//        }
//    }
//
//    static func updateStatus(pool: Pool, status: Int, completion: @escaping CompletionBoolHandler) {
//        let reference = Constants.shared.db.collection("pools")
//        guard let id = pool.id else {
//            DispatchQueue.main.async {
//                completion(false)
//            }
//            return
//        }
//        var data = pool.representation
//        data["status"] = status
//        reference.document(id).updateData(["status": status], completion: { (error) in
//            DispatchQueue.main.async {
//                if let _ = error {
//                    completion(false)
//                    return
//                }
//                completion(true)
//            }
//        })
//    }
//
//    static func all(gameId: String?, completion: @escaping CompletionHandler) {
//        let _ = Constants.shared.db.collection("pools")
//            .whereField("gameId", isEqualTo: gameId ?? "")
//            .addSnapshotListener { (snapshot, error) in
//                guard let snapshot = snapshot else {
//                    DispatchQueue.main.async {
//                        completion([Pool](), nil)
//                    }
//                    return
//                }
//                var pools = [Pool]()
//                snapshot.documents.forEach({ (snap) in
//                    if let pool = Pool(document: snap) {
//                        pools.append(pool)
//                    }
//                })
//                pools = pools.sorted()
//                DispatchQueue.main.async {
//                    completion(pools, nil)
//                }
//        }
//    }
}
