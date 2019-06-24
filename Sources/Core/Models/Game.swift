//
//  Game.swift
//  HotBox
//
//  Created by Mark Evans on 12/4/18.
//  Copyright © 2018 Mark Evans. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase
import ObjectMapper

struct Game {

    var id: String?
    var awayTeamId: String
    var homeTeamId: String
    var sport: String?
    var startDateTimeUTC: Date?
    var status: Int
    var awayTeamRef: DocumentReference?
    var homeTeamRef: DocumentReference?
    var createdAt: Timestamp?
    var isEligibleForMarketplace: Bool
    var periods: [Period]
    var statusDetail: [String: Any]?

    var representation: [String : Any] {
        var rep: [String : Any] = [
            "awayTeamId": awayTeamId,
            "homeTeamId": homeTeamId,
            "status": status,
            "isEligibleForMarketplace": isEligibleForMarketplace,
            "periods": periods
        ]
        if let id = id {
            rep["id"] = id
        }
        if let createdAt = createdAt {
            rep["created_at"] = createdAt
        }
        if let startDateTimeUTC = startDateTimeUTC {
            rep["startDateTimeUTC"] = startDateTimeUTC
        }
        if let sport = sport {
            rep["sport"] = sport
        }
        if let statusDetail = statusDetail {
            rep["statusDetail"] = statusDetail
        }
        return rep
    }

    init(awayTeamId: String, homeTeamId: String, status: Int) {
        self.id = nil
        self.awayTeamId = awayTeamId
        self.homeTeamId = homeTeamId
        self.awayTeamRef = Constants.shared.db.collection("teams").document(awayTeamId)
        self.homeTeamRef = Constants.shared.db.collection("teams").document(homeTeamId)
        self.sport = nil
        self.startDateTimeUTC = nil
        self.status = status
        self.createdAt = nil
        self.periods = [Period]()
        self.isEligibleForMarketplace = false
        self.statusDetail = nil
    }

    init?(doc: DocumentSnapshot) {
        let data = doc.data()

        self.id = doc.documentID

        if let createdAt = doc.get("created_at") as? Timestamp {
            self.createdAt = createdAt
        }

        if let awayTeamRef = data?["awayTeamRef"] as? DocumentReference {
            self.awayTeamRef = awayTeamRef
        }

        if let homeTeamRef = data?["homeTeamRef"] as? DocumentReference {
            self.homeTeamRef = homeTeamRef
        }

        if let sport = data?["sport"] as? String {
            self.sport = sport
        }

        if let statusDetail = data?["statusDetail"] as? [String: Any] {
            self.statusDetail = statusDetail
        }

        guard let status = data?["status"] as? Int else {
            return nil
        }

        self.status = status

        guard let awayTeamId = data?["awayTeamId"] as? String else {
            return nil
        }

        self.awayTeamId = awayTeamId

        guard let homeTeamId = data?["homeTeamId"] as? String else {
            return nil
        }

        guard let isEligibleForMarketplace = data?["isEligibleForMarketplace"] as? Bool else {
            return nil
        }

        self.isEligibleForMarketplace = isEligibleForMarketplace

        var periods_ = [Period]()
        if let periods = data?["periods"] as? [[String: Any]] {
            periods.forEach { (period) in
                if
                    let name = period["name"] as? String,
                    let awayScore = period["awayScore"] as? Int?,
                    let homeScore = period["homeScore"] as? Int?,
                    let order = period["sortOrder"] as? Int,
                    let status = period["status"] as? Int
                {
                    periods_.append(Period(name: name, awayScore: awayScore, homeScore: homeScore, sortOrder: order, status: status))
                }
            }
        }
        self.periods = periods_

        self.homeTeamId = homeTeamId

        if let startDateTimeUTC = data?["startDateTimeUTC"] as? Timestamp {
            self.startDateTimeUTC = Date(timeIntervalSince1970: TimeInterval(startDateTimeUTC.seconds))
        }
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data(with: ServerTimestampBehavior.estimate)

        self.id = document.documentID

        if let createdAt = document.get("created_at") as? Timestamp {
            self.createdAt = createdAt
        }

        if let awayTeamRef = data["awayTeamRef"] as? DocumentReference {
            self.awayTeamRef = awayTeamRef
        }

        if let homeTeamRef = data["homeTeamRef"] as? DocumentReference {
            self.homeTeamRef = homeTeamRef
        }

        if let sport = data["sport"] as? String {
            self.sport = sport
        }

        if let statusDetail = data["statusDetail"] as? [String: Any] {
            self.statusDetail = statusDetail
        }

        guard let status = data["status"] as? Int else {
            return nil
        }

        self.status = status

        guard let awayTeamId = data["awayTeamId"] as? String else {
            return nil
        }

        self.awayTeamId = awayTeamId

        guard let homeTeamId = data["homeTeamId"] as? String else {
            return nil
        }

        self.homeTeamId = homeTeamId

        guard let isEligibleForMarketplace = data["isEligibleForMarketplace"] as? Bool else {
            return nil
        }

        self.isEligibleForMarketplace = isEligibleForMarketplace

        var periods_ = [Period]()
        if let periods = data["periods"] as? [[String: Any]] {
            periods.forEach { (period) in
                if
                    let name = period["name"] as? String,
                    let awayScore = period["awayScore"] as? Int?,
                    let homeScore = period["homeScore"] as? Int?,
                    let order = period["sortOrder"] as? Int,
                    let status = period["status"] as? Int
                {
                    periods_.append(Period(name: name, awayScore: awayScore, homeScore: homeScore, sortOrder: order, status: status))
                }
            }
        }
        self.periods = periods_

        if let startDateTimeUTC = data["startDateTimeUTC"] as? Timestamp {
            self.startDateTimeUTC = Date(timeIntervalSince1970: TimeInterval(startDateTimeUTC.seconds))
        }
    }
}

extension Game: Comparable {
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.startDateTimeUTC != nil && rhs.startDateTimeUTC != nil && lhs.startDateTimeUTC! == rhs.startDateTimeUTC!
    }

    static func < (lhs: Game, rhs: Game) -> Bool {
        return lhs.startDateTimeUTC != nil && rhs.startDateTimeUTC != nil && lhs.startDateTimeUTC! < rhs.startDateTimeUTC!
    }
}

extension Game {

    var gameStatus: GameStatus? {
        if let json = self.statusDetail, let gameStatusDetail = Mapper<GameStatus>().map(JSON: json) {
            return gameStatusDetail
        }
        return nil
    }

    static func queryGame(gameId: String, userId: String, completion: @escaping CompletionHandler) {
        let poolReference = Constants.shared.db.collection("pools")
        poolReference.whereField("gameId", isEqualTo: gameId).whereField("userId", isEqualTo: userId).limit(to: 1).getDocuments(completion: { (poolsQuerySnap, error) in
            guard let poolsQuerySnap = poolsQuerySnap else {
                DispatchQueue.main.async {
                    completion(nil, NSError(domain: "\(error?.localizedDescription ?? "No error")", code: 400, userInfo: nil))
                }
                return
            }
            if let doc = poolsQuerySnap.documents.first, let pool = Pool(document: doc), pool.status < 2 {
                DispatchQueue.main.async {
                    completion(pool, nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
            }
        })
    }

    static func queryGame(gameId: String, completion: @escaping CompletionHandler) {
        let _ = Constants.shared.db.collection("games").document(gameId).addSnapshotListener { (docSnap, error) in
            guard let docSnap = docSnap else {
                DispatchQueue.main.async {
                    completion(nil, NSError(domain: "\(error?.localizedDescription ?? "No error")", code: 400, userInfo: nil))
                }
                return
            }
            if let game = Game(doc: docSnap) {
                DispatchQueue.main.async {
                    completion(game, nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
            }
        }
    }

    static func queryGameAndComplete(gameId: String, userId: String, completion: @escaping CompletionHandler) {
        let poolReference = Constants.shared.db.collection("pools")
        poolReference.whereField("gameId", isEqualTo: gameId).whereField("userId", isEqualTo: userId).limit(to: 1).getDocuments(completion: { (poolsQuerySnap, error) in
            guard let poolsQuerySnap = poolsQuerySnap else {
                DispatchQueue.main.async {
                    completion(nil, NSError(domain: "\(error?.localizedDescription ?? "No error")", code: 400, userInfo: nil))
                }
                return
            }
            if let doc = poolsQuerySnap.documents.first, let pool = Pool(document: doc) {
                DispatchQueue.main.async {
                    completion(pool, nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
            }
        })
    }

    static func createOrQueryGame(vc: UIViewController, userName: String, userId: String, gameId: String, game: Game, entryFee: Int, status: Int, completion: @escaping CompletionHandler) {
        self.queryGame(gameId: gameId, userId: userId) { (success, _) in
            if let pool = success as? Pool {
                DispatchQueue.main.async {
                    completion(pool, nil)
                }
                return
            }
            var poolReference: CollectionReference {
                return Constants.shared.db.collection("pools")
            }
            var pool = Pool(awayScoringIndex: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].shuffled(), homeScoringIndex: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].shuffled(), entryFee: entryFee, gameId: gameId, userId: userId, name: "\(userName)'s Pool \(game.awayTeamId) @ \(game.homeTeamId)", status: status)
            var ref: DocumentReference? = nil
            ref = poolReference.addDocument(data: pool.representation) { error in
                if let e = error {
                    DispatchQueue.main.async {
                        completion(nil, NSError(domain: e.localizedDescription, code: 400, userInfo: nil))
                    }
                    return
                }
                else if let poolId = ref?.documentID {
                    pool.id = poolId
                    DispatchQueue.main.async {
                        completion(pool, nil)
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
                }
            }
        }
    }

    static func getRandomPoolFromGame(game: Game, completion: @escaping CompletionHandler) {
        guard let gameId = game.id else {
            DispatchQueue.main.async {
                completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
            }
            return
        }
        let poolReference = Constants.shared.db.collection("pools")
        poolReference.whereField("gameId", isEqualTo: gameId).getDocuments(completion: { (poolsQuerySnap, error) in
            guard let poolsQuerySnap = poolsQuerySnap else {
                DispatchQueue.main.async {
                    completion(nil, NSError(domain: "\(error?.localizedDescription ?? "No error")", code: 400, userInfo: nil))
                }
                return
            }
            if let doc = poolsQuerySnap.documents.randomElement(), let pool = Pool(document: doc) {
                DispatchQueue.main.async {
                    completion((game, pool), nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
            }
        })
    }

    static func getRandomPoolFromGame(gameApi: GameApi, completion: @escaping CompletionHandler) {
        guard let gameId = gameApi.gameId else {
            DispatchQueue.main.async {
                completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
            }
            return
        }
        let poolReference = Constants.shared.db.collection("pools")
        poolReference.whereField("gameId", isEqualTo: gameId).getDocuments(completion: { (poolsQuerySnap, error) in
            guard let poolsQuerySnap = poolsQuerySnap else {
                DispatchQueue.main.async {
                    completion(nil, NSError(domain: "\(error?.localizedDescription ?? "No error")", code: 400, userInfo: nil))
                }
                return
            }
            if let doc = poolsQuerySnap.documents.randomElement(), let pool = Pool(document: doc) {
                Pool.gameAndPool(poolId: pool.id ?? "", completion: { (success, _) in
                    if let result = success as? (Game, Pool) {
                        let game = result.0
                        let pool = result.1
                        DispatchQueue.main.async {
                            completion((game, pool), nil)
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
                    }
                })
                return
            }
            DispatchQueue.main.async {
                completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
            }
        })
    }

    static func getAllGames(competiton: CompetitionApi, completion: @escaping CompletionHandler) {
        guard let competitionId = competiton.competitionId else {
            DispatchQueue.main.async {
                completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
            }
            return
        }
        let gamesReference = Constants.shared.db.collection("games")
        gamesReference.whereField("competitionId", isEqualTo: competitionId).getDocuments(completion: { (gamesQuerySnap, error) in
            guard let gamesQuerySnap = gamesQuerySnap else {
                DispatchQueue.main.async {
                    completion(nil, NSError(domain: "\(error?.localizedDescription ?? "No error")", code: 400, userInfo: nil))
                }
                return
            }
            var games = [Game]()
            gamesQuerySnap.documents.forEach({ (doc) in
                if let game = Game(document: doc) {
                    games.append(game)
                }
            })
            DispatchQueue.main.async {
                completion(games, nil)
            }
        })
    }

    static func getRandomGameAndPool(competiton: CompetitionApi, completion: @escaping CompletionHandler) {
        guard let competitionId = competiton.competitionId else {
            DispatchQueue.main.async {
                completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
            }
            return
        }
        let gamesReference = Constants.shared.db.collection("games")
        gamesReference.whereField("competitionId", isEqualTo: competitionId).getDocuments(completion: { (gamesQuerySnap, error) in
            guard let gamesQuerySnap = gamesQuerySnap else {
                DispatchQueue.main.async {
                    completion(nil, NSError(domain: "\(error?.localizedDescription ?? "No error")", code: 400, userInfo: nil))
                }
                return
            }
            var games = [Game]()
            gamesQuerySnap.documents.forEach({ (doc) in
                if let game = Game(document: doc) {
                    games.append(game)
                }
            })
            games = games.filter({$0.status < HotBoxStatus.complete.rawValue})
            if let game = games.randomElement(), let gameId = game.id {
                let poolReference = Constants.shared.db.collection("pools")
                poolReference.whereField("gameId", isEqualTo: gameId).getDocuments(completion: { (poolsQuerySnap, error) in
                    guard let poolsQuerySnap = poolsQuerySnap else {
                        DispatchQueue.main.async {
                            completion(nil, NSError(domain: "\(error?.localizedDescription ?? "No error")", code: 400, userInfo: nil))
                        }
                        return
                    }
                    if let doc = poolsQuerySnap.documents.randomElement(), let pool = Pool(document: doc) {
                        DispatchQueue.main.async {
                            completion((game, pool), nil)
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completion((game, Pool(doc: nil)), nil)
                    }
                    return
                })
                return
            }
            DispatchQueue.main.async {
                completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
            }
        })
    }
}
