//
//  ClientRouter.swift
//
//  Created by 3Advance iOS Swagger Generator.
//  Copyright © 3Advance, LLC. All rights reserved.
//

enum HotBoxRouter: URLRequestConvertible {
    case createUser(String, String)
    case createTransaction(Int, Int)
    case createEntry(String, Int)
    case buyEntryForSale(String, Int)
    case cancelEntryForSale(String, Int)
    case markEntryForSale(String, Int, Int, Int)
    case pools(Int, Int, Int, Int?)
    case games(String)
    case marketEntryForSale(String, Int, Int, Int)
    case denominations
    case buyEntryForBid(String, Int, Int, Int, Int, Int, String?, [UserBidEntry])
    case cancelBid(String)
    case acceptBid(String, String)
    case competitions
    case gamePools(String, String, Int?)
    case me
    case updateMe(String, String, Int?, Int?)
    case durationPresets
    case transactions(Int?, Int)
    case activityLogs(Int)

    var method: HTTPMethod {
        switch self {
            case .createUser:
                return .post
            case .createTransaction:
                return .post
            case .createEntry:
                return .post
            case .buyEntryForSale:
                return .patch
            case .cancelEntryForSale:
                return .patch
            case .markEntryForSale:
                return .post
            case .pools:
                return .get
            case .games:
                return .get
            case .marketEntryForSale:
                return .get
            case .denominations:
                return .get
            case .buyEntryForBid:
                return .post
            case .cancelBid:
                return .put
            case .acceptBid:
                return .put
            case .competitions:
                return .get
            case .gamePools:
                return .get
            case .me:
                return .get
            case .updateMe:
                return .put
            case .durationPresets:
                return .get
            case .transactions:
                return .get
            case .activityLogs:
                return .get
        }
    }

    var path: String {
        switch self {
            case .createUser:
                return "/api/me/register"
            case .createTransaction:
                return "/api/me/transactions"
            case .createEntry(let poolId, _):
                return "/api/me/pools/\(poolId)/entries"
            case .buyEntryForSale(let poolId, let boxNumber):
                return "/api/me/pools/\(poolId)/entries/\(boxNumber)/buyForSale"
            case .cancelEntryForSale(let poolId, let boxNumber):
                return "/api/me/pools/\(poolId)/entries/\(boxNumber)/cancelSale"
            case .markEntryForSale(let poolId, let boxNumber, _, _):
                return "/api/me/pools/\(poolId)/entries/\(boxNumber)/forSale"
            case .games(let competitionId):
                return "/api/competitions/\(competitionId)/games"
            case .marketEntryForSale:
                return "/api/marketplace/forsale"
            case .pools:
                return "/api/me/pools"
            case .denominations:
                return "/api/meta/denominations"
            case .buyEntryForBid:
                return "/api/me/bids"
            case .cancelBid(let marketplaceId):
                return "/api/me/bids/\(marketplaceId)/cancel"
            case .acceptBid(let marketplaceId, _):
                return "/api/me/bids/\(marketplaceId)/accept"
            case .competitions:
                return "/api/competitions"
            case .gamePools(let competitionId, let gameId, _):
                return "/api/competitions/\(competitionId)/games/\(gameId)/pools"
            case .me:
                return "/api/me"
            case .updateMe:
                return "/api/me"
            case .durationPresets:
                return "/api/meta/durationpresets"
            case .transactions:
                return "/api/me/transactions"
            case .activityLogs:
                return "/api/me/activity"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try SecureKeys.shared.FirebaseApiEndpoint.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
            case .createUser(let firstName, let lastName):
                let parameters: [String: Any] = [
                    "firstName": firstName,
                    "lastName": lastName
                ]
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)

            case .createTransaction(let amount, let type):
                let parameters: [String: Any] = [
                    "amount": amount,
                    "type": type
                ]
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)

            case .createEntry(_, let boxNumber):
                let parameters: [String: Any] = [
                    "boxNumber": boxNumber
                ]
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)

            case .buyEntryForSale:
                let parameters: [String: Any] = [String: Any]()
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)

            case .cancelEntryForSale:
                let parameters: [String: Any] = [String: Any]()
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)

            case .markEntryForSale(_, _, let saleAmount, let expireInMinutes):
                let parameters: [String: Any] = [
                    "saleAmount": saleAmount,
                    "expireInMinutes": expireInMinutes
                ]
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)

            case .pools(let status, let page, let pageSize, let entryFee):
                var parameters: [String: Any] = [
                    "poolStatus": status,
                    "page": page,
                    "pageSize": pageSize
                ]
                if let entryFee = entryFee {
                    parameters["entryFee"] = entryFee
                }
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)

            case .games:
                urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)

            case .marketEntryForSale(let gameId, let entryFee, let homeScore, let awayScore):
                let parameters: [String: Any] = [
                    "gameId": gameId,
                    "entryFee": entryFee,
                    "homeScore": homeScore,
                    "awayScore": awayScore
                ]
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)

            case .denominations:
                urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)

            case .buyEntryForBid(let gameId, let entryFee, let bidAmount, let expireInMinutes, let awayScore, let homeScore, let entryId, let offeredEntries):
                var parameters: [String: Any] = [
                    "gameId": gameId,
                    "entryFee": entryFee,
                    "bidAmount": bidAmount,
                    "expireInMinutes": expireInMinutes,
                    "awayScore": awayScore,
                    "homeScore": homeScore,
                    "offeredEntries": offeredEntries.toJSON()
                ]
                if let entryId = entryId {
                    parameters["entryId"] = entryId
                }
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)

            case .cancelBid:
                let parameters: [String: Any] = [String: Any]()
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)

            case .acceptBid(_, let entryId):
                let parameters: [String: Any] = [
                    "entryId": entryId
                ]
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)

            case .competitions:
                let parameters: [String: Any] = [
                    "pageSize": 10000
                ]
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)

            case .gamePools(_, _, let entryFee):
                var parameters: [String: Any] = [
                    "pageSize": 10000
                ]
                if let entryFee = entryFee {
                    parameters["entryFee"] = entryFee
                }
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)

            case .me:
                urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)

            case .updateMe(let firstName, let lastName, let sale, let bid):
                var parameters: [String: Any] = [
                    "firstName": firstName,
                    "lastName": lastName
                ]
                if let sale = sale {
                    parameters["saleDurationPresetMins"] = sale
                }
                if let bid = bid {
                    parameters["bidDurationPresetMins"] = bid
                }
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)

            case .durationPresets:
                urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
            
            case .transactions(let timeStamp, let pageSize):
                var parameters: [String: Any] = [
                    "pageSize": pageSize
                ]
                if let timeStamp = timeStamp {
                    parameters["lastReceivedCreatedDateTimestamp"] = timeStamp
                }
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            
            case .activityLogs(let pageSize):
                let parameters: [String: Any] = [
                    "pageSize": pageSize
                ]
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        self.getServicePath(urlRequest: urlRequest)
        return urlRequest
    }

    private func getServicePath(urlRequest: URLRequest) {
        guard let u = urlRequest.url?.absoluteString else {
            return
        }
        let url = URL(string: u)!
        let urlRequest = URLRequest(url: url)
        do {
            let encodedURLRequest = try URLEncoding.queryString.encode(urlRequest, with: nil)
            if encodedURLRequest.url != nil {
                print("servicepath: \(encodedURLRequest.url!.absoluteString)")
            }
        } catch _ {
            print("servicepath: error")
        }
    }
}
