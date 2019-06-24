//
//  Token.swift
//
//
//  Created by Mark Evans on 6/27/17.
//  Copyright © 2017 3Advance, LLC. All rights reserved.
//

import Foundation
import ObjectMapper

class Score: NSObject, Mappable {

    var awayScore : Int = 0
    var homeScore : Int = 0
    var position : Int = 0

    class func newInstance(_ map: Map) -> Mappable? {
        return Score()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map) {
        awayScore <- map["awayScore"]
        homeScore <- map["homeScore"]
        position <- map["position"]
    }
}

extension Score {
    static func calculate(position: String, home: [Int], away: [Int]) -> (Score?, IndexPath?) {
        var array = Score.map(home: home, away: away)
        let pos = Int(position) ?? 1
        if array.count > 0 {
            var index = pos-1
            if index >= 100 { index = 99 } else if index < 0 { index = 0 }
            if index < array.count {
                let score = array[index]
                let indexPath = IndexPath(row: away.firstIndex(of: score.awayScore) ?? 0, section: home.firstIndex(of: score.homeScore) ?? 0)
                return (score, indexPath)
            }
        }
        return (nil, nil)
    }

    static func boxIsHot(position: String, home: [Int], away: [Int], hotBoxes: [(String, Int, Int)]) -> Bool {
        if let score = Score.calculate(position: "\(position)", home: home, away: away).0 {
            for value in hotBoxes {
                let hotAway = value.1
                let hotHome = value.2
                let awayValue = hotAway % 10
                let homeValue = hotHome % 10
                if score.awayScore == awayValue && score.homeScore == homeValue {
                    return true
                }
            }
        }
        return false
    }

    static func boxIsProjectedHot(position: String, homeIndex: [Int], awayIndex: [Int], hotBoxes: [(String, Int, Int)], addAway: Int, addHome: Int) -> (Bool, IndexPath?) {
        for value in hotBoxes {
            let hotAway = value.1+addAway
            let hotHome = value.2+addHome
            let awayValue = hotAway % 10
            let homeValue = hotHome % 10
            if let score = Score.calculate(position: "\(position)", home: homeIndex, away: awayIndex).0 {
                if score.awayScore == awayValue && score.homeScore == homeValue {
                    return (true, Score.calculate(position: "\(position)", home: homeIndex, away: awayIndex).1)
                }
            }
        }
        return (false, Score.calculate(position: "\(position)", home: homeIndex, away: awayIndex).1)
    }

    static func projectedHot(homeIndex: [Int], awayIndex: [Int], hotBoxes: [(String, Int, Int)]) -> [IndexPath] {
        var projected = [IndexPath]()
        for position in stride(from: 1, through: 100, by: 1) {
            let condition = Score.boxIsHot(position: "\(position)", home: homeIndex, away: awayIndex, hotBoxes: hotBoxes)
            if condition {
                let away = Score.calculate(position: "\(position)", home: homeIndex, away: awayIndex).0?.awayScore ?? 0
                let home = Score.calculate(position: "\(position)", home: homeIndex, away: awayIndex).0?.homeScore ?? 0
                let awayValue = away
                let homeValue = home
                let homeWithFG = (homeValue + 3) % 10
                let homeWithTD = (homeValue + 7) % 10
                let awayWithFG = (awayValue + 3) % 10
                let awayWithTD = (awayValue + 7) % 10
                var variations = [(Int, Int)]()
                variations.append((awayValue, homeWithFG))
                variations.append((awayValue, homeWithTD))
                variations.append((awayWithFG, homeValue))
                variations.append((awayWithTD, homeValue))
                for variation in variations {
                    let sAway = variation.0
                    let sHome = variation.1
                    let array = Score.map(home: homeIndex, away: awayIndex)
                    var idxRow = 0
                    if let indexOfRow = homeIndex.firstIndex(where: { (current) -> Bool in
                        if current == sHome {
                            return true
                        }
                        return false
                    }) {
                        idxRow = indexOfRow+1
                    }
                    var idxSection = 0
                    if let indexOfSection = awayIndex.firstIndex(where: { (current) -> Bool in
                        if current == sAway {
                            return true
                        }
                        return false
                    }) {
                        idxSection = indexOfSection+1
                    }
                    var position = 1
                    for score in array {
                        if score.awayScore == sAway && score.homeScore == sHome {
                            break
                        }
                        position += 1
                    }
                    let indexPath = IndexPath(row: idxSection, section: idxRow)
                    projected.append(indexPath)
                }
            }
        }
        return projected
    }

    static func highlightMarketPlaceItem(position: String, home: [Int], away: [Int], marketPlaceItems: [MarketPlace], games: [Game]) -> (Bool, Int) {
        var type = 0
        if let score = Score.calculate(position: "\(position)", home: home, away: away).0 {
            let marketItems = marketPlaceItems.sorted(by: {$0.marketplaceType < $1.marketplaceType})
            for market in marketItems {
                let hotAway = market.awayScore
                let hotHome = market.homeScore
                let awayValue = hotAway % 10
                let homeValue = hotHome % 10
                if score.awayScore == awayValue && score.homeScore == homeValue && market.expireDateTimeUTC.timeIntervalSince1970 > Date().timeIntervalSince1970 && market.isActive && market.gameStatus(games: games) < 2 {
                    type = market.marketplaceType
                    return (true, type)
                }
            }
        }
        return (false, type)
    }

    static func highlightMarketPlaceItem(poolId: String, position: String, home: [Int], away: [Int], marketPlaceItems: [MarketPlace], games: [Game]) -> (Bool, Int) {
        var type = 0
        if let score = Score.calculate(position: "\(position)", home: home, away: away).0 {
            let marketItems = marketPlaceItems.filter({$0.entryId == "\(poolId)_\(position)"}).sorted(by: {$0.marketplaceType < $1.marketplaceType})
            for market in marketItems {
                let hotAway = market.awayScore
                let hotHome = market.homeScore
                let awayValue = hotAway % 10
                let homeValue = hotHome % 10
                if score.awayScore == awayValue && score.homeScore == homeValue && market.expireDateTimeUTC.timeIntervalSince1970 > Date().timeIntervalSince1970 && market.isActive && market.gameStatus(games: games) < 2 {
                    type = market.marketplaceType
                    return (true, type)
                }
            }
        }
        return (false, type)
    }

    static func highlightMarketPlaceSaleItems(poolId: String, position: String, home: [Int], away: [Int], marketPlaceItems: [MarketPlace], games: [Game]) -> (Bool, Int) {
        var type = 0
        if let score = Score.calculate(position: "\(position)", home: home, away: away).0 {
            let marketItems = marketPlaceItems.filter({$0.entryId == "\(poolId)_\(position)" && $0.marketplaceType == 0}).sorted(by: {$0.marketplaceType < $1.marketplaceType})
            for market in marketItems {
                let hotAway = market.awayScore
                let hotHome = market.homeScore
                let awayValue = hotAway % 10
                let homeValue = hotHome % 10
                if score.awayScore == awayValue && score.homeScore == homeValue && market.expireDateTimeUTC.timeIntervalSince1970 > Date().timeIntervalSince1970 && market.isActive && market.gameStatus(games: games) < 2 {
                    type = market.marketplaceType
                    return (true, type)
                }
            }
        }
        return (false, type)
    }

    static func highlightMarketPlaceBidItems(gameId: String?, entryFee: Int, position: String, home: [Int], away: [Int], marketPlaceItems: [MarketPlace], games: [Game]) -> (Bool, Int) {
        var type = 0
        if let score = Score.calculate(position: "\(position)", home: home, away: away).0 {
            let marketItems = marketPlaceItems.filter({$0.gameId == gameId && $0.poolEntryFee == entryFee && $0.marketplaceType == 1}).sorted(by: {$0.marketplaceType < $1.marketplaceType})
            for market in marketItems {
                let hotAway = market.awayScore
                let hotHome = market.homeScore
                let awayValue = hotAway % 10
                let homeValue = hotHome % 10
                if score.awayScore == awayValue && score.homeScore == homeValue && market.expireDateTimeUTC.timeIntervalSince1970 > Date().timeIntervalSince1970 && market.isActive && market.gameStatus(games: games) < 2 {
                    type = market.marketplaceType
                    return (true, type)
                }
            }
        }
        return (false, type)
    }

    static func map(home: [Int], away: [Int]) -> [Score] {
        var scoringMapArray = [Score]()
        var pos = 1
        for homeScore in home {
            for awayScore in away {
                let score = Score()
                score.awayScore = awayScore
                score.homeScore = homeScore
                score.position = pos
                scoringMapArray.append(score)
                pos += 1
            }
        }
        return scoringMapArray
    }
}
