//
//  HotBoxService.swift
//
//  Created by 3Advance iOS Swagger Generator.
//  Copyright © 3Advance, LLC. All rights reserved.
//

import Foundation
import UIKit

public extension HotBoxService {

    // MARK: OAuth Methods

//    func createUser(firstName: String, lastName: String, completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.createUser(firstName, lastName))
//                        .validate(statusCode: 200..<300)
//                        .responseObject { (response: DataResponse<UserApi>) in
//                            DispatchQueue.main.async {
//                                if let user = response.result.value {
//                                    UINotificationFeedbackGenerator().notificationOccurred(.success)
//                                    completion(user, nil)
//                                }
//                                else if let error = response.result.error {
//                                    completion(nil, error.handleError(response: response.response))
//                                }
//                                else {
//                                    completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//                                }
//                            }
//                    }
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func createTransaction(amount: Int, type: Int, completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.createTransaction(amount, type))
//                        .validate(statusCode: 200..<300)
//                        .responseObject { (response: DataResponse<TransactionApi>) in
//                            DispatchQueue.main.async {
//                                if let transaction = response.result.value {
//                                    UINotificationFeedbackGenerator().notificationOccurred(.success)
//                                    completion(transaction, nil)
//                                }
//                                else if let error = response.result.error {
//                                    completion(nil, error.handleError(response: response.response))
//                                }
//                                else {
//                                    completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//                                }
//                            }
//                    }
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func createEntry(poolId: String, boxNumber: Int, completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.createEntry(poolId, boxNumber))
//                        .validate(statusCode: 200..<300)
//                        .responseObject { (response: DataResponse<EntryApi>) in
//                            DispatchQueue.main.async {
//                                if let transaction = response.result.value {
//                                    UINotificationFeedbackGenerator().notificationOccurred(.success)
//                                    completion(transaction, nil)
//                                }
//                                else if let error = response.result.error {
//                                    completion(nil, error.handleError(response: response.response))
//                                }
//                                else {
//                                    completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//                                }
//                            }
//                    }
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func markEntryForSale(poolId: String, boxNumber: Int, amount: Int, expireInMinutes: Int, completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.markEntryForSale(poolId, boxNumber, amount, expireInMinutes))
//                        .validate(statusCode: 200..<300)
//                        .responseObject { (response: DataResponse<EntryApi>) in
//                            DispatchQueue.main.async {
//                                if let entry = response.result.value {
//                                    UINotificationFeedbackGenerator().notificationOccurred(.success)
//                                    completion(entry, nil)
//                                }
//                                else if let error = response.result.error {
//                                    completion(nil, error.handleError(response: response.response))
//                                }
//                                else {
//                                    completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//                                }
//                            }
//                    }
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func buyEntryForSale(poolId: String, boxNumber: Int, completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.buyEntryForSale(poolId, boxNumber))
//                        .validate(statusCode: 200..<300)
//                        .responseObject { (response: DataResponse<EntryApi>) in
//                            DispatchQueue.main.async {
//                                if let entry = response.result.value {
//                                    UINotificationFeedbackGenerator().notificationOccurred(.success)
//                                    completion(entry, nil)
//                                }
//                                else if let error = response.result.error {
//                                    completion(nil, error.handleError(response: response.response))
//                                }
//                                else {
//                                    completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//                                }
//                            }
//                    }
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func cancelEntryForSale(poolId: String, boxNumber: Int, completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.cancelEntryForSale(poolId, boxNumber))
//                        .validate(statusCode: 200..<300)
//                        .responseObject { (response: DataResponse<EntryApi>) in
//                            DispatchQueue.main.async {
//                                if let entry = response.result.value {
//                                    UINotificationFeedbackGenerator().notificationOccurred(.success)
//                                    completion(entry, nil)
//                                }
//                                else if let error = response.result.error {
//                                    completion(nil, error.handleError(response: response.response))
//                                }
//                                else {
//                                    completion(nil, NSError(domain: self.DEFAULT_ERROR_MSG, code: self.DEFAULT_ERROR_CODE))
//                                }
//                            }
//                    }
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func getPools(status: Int, entryFee: Int?, completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.pools(status, 1, 1000, entryFee))
//                        .validate(statusCode: 200..<300)
//                        .responseArray { (response: DataResponse<[PoolApi]>) in
//                            if let pools = response.result.value {
//                                completion(pools, nil)
//                            } else if let error = response.result.error {
//                                completion(nil, error.handleError(response: response.response))
//                            }
//                            else {
//                                completion(nil, NSError(domain: self.DEFAULT_ERROR_MSG, code: self.DEFAULT_ERROR_CODE, userInfo: nil))
//                            }
//                    }
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func getGamePools(competitionId: String, gameId: String, entryFee: Int?, completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.gamePools(competitionId, gameId, entryFee))
//                        .validate(statusCode: 200..<300)
//                        .responseArray { (response: DataResponse<[PoolApi]>) in
//                            if let pools = response.result.value {
//                                completion(pools, nil)
//                            } else if let error = response.result.error {
//                                completion(nil, error.handleError(response: response.response))
//                            }
//                            else {
//                                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE, userInfo: nil))
//                            }
//                    }
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func getCompetitions(completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.competitions)
//                        .validate(statusCode: 200..<300)
//                        .responseArray { (response: DataResponse<[CompetitionApi]>) in
//                            if let competitions = response.result.value {
//                                completion(competitions, nil)
//                            } else if let error = response.result.error {
//                                completion(nil, error.handleError(response: response.response))
//                            }
//                            else {
//                                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE, userInfo: nil))
//                            }
//                    }
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func getGames(competitionId: String, completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.games(competitionId))
//                        .validate(statusCode: 200..<300)
//                        .responseArray { (response: DataResponse<[GameApi]>) in
//                            if let games = response.result.value {
//                                completion(games, nil)
//                            } else if let error = response.result.error {
//                                completion(nil, error.handleError(response: response.response))
//                            }
//                            else {
//                                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE, userInfo: nil))
//                            }
//                    }
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func getTransactions(lastReceivedCreatedDateTimestamp: Int? = nil, pageSize: Int = 100, completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.transactions(lastReceivedCreatedDateTimestamp, pageSize))
//                        .validate(statusCode: 200..<300)
//                        .responseArray { (response: DataResponse<[TransactionApi]>) in
//                            if let games = response.result.value {
//                                completion(games, nil)
//                            } else if let error = response.result.error {
//                                completion(nil, error.handleError(response: response.response))
//                            }
//                            else {
//                                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE, userInfo: nil))
//                            }
//                    }
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func getActivityLogs(pageSize: Int = 100, completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.activityLogs(pageSize))
//                        .validate(statusCode: 200..<300)
//                        .responseArray { (response: DataResponse<[ActivityLogApi]>) in
//                            if let games = response.result.value {
//                                completion(games, nil)
//                            } else if let error = response.result.error {
//                                completion(nil, error.handleError(response: response.response))
//                            }
//                            else {
//                                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE, userInfo: nil))
//                            }
//                    }
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func getMarketEntryForSale(gameId: String, entryFee: Int, homeScore: Int, awayScore: Int, completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.marketEntryForSale(gameId, entryFee, homeScore, awayScore))
//                        .validate(statusCode: 200..<300)
//                        .responseObject { (response: DataResponse<MarketEntryApi>) in
//                            DispatchQueue.main.async {
//                                if let entry = response.result.value {
//                                    completion(entry, nil)
//                                }
//                                else if let error = response.result.error {
//                                    completion(nil, error.handleError(response: response.response))
//                                }
//                                else {
//                                    completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//                                }
//                            }
//                    }
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func cancelBid(marketplaceId: String, completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.cancelBid(marketplaceId))
//                        .validate(statusCode: 200..<300)
//                        .response(completionHandler: { (response) in
//                            if let error = response.error {
//                                completion(false, error.handleError(response: response.response))
//                            }
//                            else {
//                                UINotificationFeedbackGenerator().notificationOccurred(.success)
//                                completion(true, nil)
//                            }
//                        })
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(false, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func acceptBid(marketplaceId: String, entryId: String, completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.acceptBid(marketplaceId, entryId))
//                        .validate(statusCode: 200..<300)
//                        .response(completionHandler: { (response) in
//                            if let error = response.error {
//                                completion(false, error.handleError(response: response.response))
//                            }
//                            else {
//                                UINotificationFeedbackGenerator().notificationOccurred(.success)
//                                completion(true, nil)
//                            }
//                        })
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(false, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func getDenominations(completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.denominations)
//                        .validate(statusCode: 200..<300)
//                        .responseJSON(completionHandler: { (response) in
//                            if let denominations = response.result.value as? [Int] {
//                                completion(denominations, nil)
//                            } else if let error = response.result.error {
//                                completion(nil, error.handleError(response: response.response))
//                            }
//                            else {
//                                completion(nil, NSError(domain: self.DEFAULT_ERROR_MSG, code: self.DEFAULT_ERROR_CODE, userInfo: nil))
//                            }
//                        })
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func getDurationPresets(completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.durationPresets)
//                        .validate(statusCode: 200..<300)
//                        .responseArray { (response: DataResponse<[DurationPresetApi]>) in
//                            if let presets = response.result.value {
//                                completion(presets, nil)
//                            } else if let error = response.result.error {
//                                completion(nil, error.handleError(response: response.response))
//                            }
//                            else {
//                                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE, userInfo: nil))
//                            }
//                    }
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func buyEntryForBid(gameId: String, entryFee: Int, bidAmount: Int, expireInMinutes: Int, awayScore: Int, homeScore: Int, entryId: String?, offeredEntries: [UserBidEntry], completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.buyEntryForBid(gameId, entryFee, bidAmount, expireInMinutes, awayScore, homeScore, entryId, offeredEntries))
//                        .validate(statusCode: 200..<300)
//                        .responseJSON(completionHandler: { (response) in
//                            if let _ = response.result.value {
//                                UINotificationFeedbackGenerator().notificationOccurred(.success)
//                                completion(EntryApi(), nil)
//                            } else if let error = response.result.error {
//                                completion(nil, error.handleError(response: response.response))
//                            }
//                            else {
//                                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE, userInfo: nil))
//                            }
//                        })
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }

    func getMe(completion: @escaping CompletionHandler) {
        DispatchQueue(label: "background", qos: .background).async {
            var firebaseToken = SecureKeys.shared.FirebaseAcessToken
            if let user = Auth.auth().currentUser {
                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
                    if let token = result?.token {
                        firebaseToken = token
                    }
                    _ = self.setupManagerWithToken(token: firebaseToken)
                    self.manager.request(HotBoxRouter.me)
                        .validate(statusCode: 200..<300)
                        .responseJSON(completionHandler: { (response) in
                            if let user = Mapper<UserApi>().map(JSONObject: response.result.value) {
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                                completion(user, nil)
                            } else if let error = response.result.error {
                                completion(nil, error.handleError(response: response.response))
                            }
                            else {
                                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE, userInfo: nil))
                            }
                        })
                })
            }
        }
    }

//    func updateMe(firstName: String, lastName: String, salePreset: Int?, bidPreset: Int?,completion: @escaping CompletionHandler) {
//        DispatchQueue(label: "background", qos: .background).async {
//            if let user = Auth.auth().currentUser {
//                user.getIDTokenResult(forcingRefresh: true, completion: { (result, error) in
//                    if let token = result?.token {
//                        _ = self.setupManagerWithToken(token: token)
//                    }
//                    self.manager?.request(ClientRouter.updateMe(firstName, lastName, salePreset, bidPreset))
//                        .validate(statusCode: 200..<300)
//                        .responseObject { (response: DataResponse<UserApi>) in
//                            DispatchQueue.main.async {
//                                if let user = response.result.value {
//                                    UINotificationFeedbackGenerator().notificationOccurred(.success)
//                                    completion(user, nil)
//                                }
//                                else if let error = response.result.error {
//                                    completion(nil, error.handleError(response: response.response))
//                                }
//                                else {
//                                    completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//                                }
//                            }
//                    }
//                })
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: HotBoxService.DEFAULT_ERROR_MSG, code: HotBoxService.DEFAULT_ERROR_CODE))
//            }
//        }
//    }
//
//    func preLoadGames() {
//        print("PRELOAD GAMES")
//        HotBoxService.shared.getCompetitions(completion: { (competitionsSuccess, _) in
//            self.competitions = [CompetitionApi]()
//            self.games = [GameUI]()
//            self.gamesApi = [GameApi]()
//            self.denominations = [Int]()
//            if let competitions = competitionsSuccess as? [CompetitionApi] {
//                self.competitions = competitions
//            }
//            let competitionId = self.competitions.filter({$0.organizationId?.uppercased() == "NFL"}).first?.competitionId ?? HotBoxService.shared.competitions.first?.competitionId ?? ""
//            HotBoxService.shared.getGames(competitionId: competitionId, completion: { (gamesSuccess, _) in
//                HotBoxService.shared.getDenominations(completion: { (denominationsSuccess, _) in
//                    if let denominations_ = denominationsSuccess as? [Int] {
//                        self.denominations = denominations_
//                    }
//                    if let games_ = gamesSuccess as? [GameApi] {
//                        self.gamesApi = games_
//                    }
//                    self.gamesApi.forEach({ (game) in
//                        self.denominations.forEach({ (denomination) in
//                            let gameUI = GameUI()
//                            gameUI.gameId = game.gameId
//                            gameUI.entryFee = denomination
//                            gameUI.awayTeamName = game.awayTeam?.teamId
//                            gameUI.homeTeamName = game.homeTeam?.teamId
//                            gameUI.startDateTimestamp = game.startDateTimestamp
//                            gameUI.isEligibleForMarketplace = game.isEligibleForMarketplace
//                            gameUI.periodsApi = game.periodsApi
//                            self.games.append(gameUI)
//                        })
//                    })
//                })
//            })
//        })
//    }
//
//    func preMyBoxes() {
//        print("PRELOAD MYBOXES")
//        HotBoxService.shared.getPools(status: 0, entryFee: nil) { (s, error) in
//            if let pools_ = s as? [PoolApi] {
//                HotBoxService.shared.upcomingPools = pools_.sorted(by: {$0.name < $1.name})
//            }
//            HotBoxService.shared.getPools(status: 1, entryFee: nil) { (ss, error) in
//                if let pools_ = ss as? [PoolApi] {
//                    HotBoxService.shared.livePools = pools_.sorted(by: {$0.name < $1.name})
//                }
//                HotBoxService.shared.getPools(status: 2, entryFee: nil) { (sss, error) in
//                    if let pools_ = sss as? [PoolApi] {
//                        HotBoxService.shared.recentPools = pools_.sorted(by: {$0.name < $1.name})
//                    }
//                }
//            }
//        }
//    }
}
