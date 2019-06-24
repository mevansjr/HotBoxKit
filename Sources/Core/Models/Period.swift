//
//  Period.swift
//  HotBox
//
//  Created by Mark Evans on 12/4/18.
//  Copyright © 2018 Mark Evans. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

struct Period {
    var id: String?
    var name: String
    var awayScore: Int?
    var homeScore: Int?
    var sortOrder: Int
    var status: Int

    var representation: [String : Any] {
        var rep: [String : Any] = [
            "name": name,
            "sortOrder": sortOrder,
            "status": status
        ]
        if let id = id {
            rep["id"] = id
        }
        if let awayScore = awayScore {
            rep["awayScore"] = awayScore
        }
        if let homeScore = homeScore {
            rep["homeScore"] = homeScore
        }
        return rep
    }

    init(name: String, awayScore: Int?, homeScore: Int?, sortOrder: Int, status: Int) {
        self.id = nil
        self.name = name
        self.awayScore = awayScore
        self.homeScore = homeScore
        self.sortOrder = sortOrder
        self.status = status
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()

        self.id = document.documentID

        guard let name = data["name"] as? String else {
            return nil
        }

        if let awayScore = data["awayScore"] as? Int {
            self.awayScore = awayScore
        }

        if let homeScore = data["homeScore"] as? Int {
            self.homeScore = homeScore
        }

        guard let sortOrder = data["sortOrder"] as? Int else {
            return nil
        }

        guard let status = data["status"] as? Int else {
            return nil
        }

        self.name = name
        self.sortOrder = sortOrder
        self.status = status
    }
}

extension Period: Comparable {
    static func == (lhs: Period, rhs: Period) -> Bool {
        return lhs.sortOrder == rhs.sortOrder
    }

    static func < (lhs: Period, rhs: Period) -> Bool {
        return lhs.sortOrder < rhs.sortOrder
    }
}

extension Period {
    static func winningPosition(period: Period, home: [Int], away: [Int], homeScore: Int, awayScore: Int) -> (Period, IndexPath, Int, IndexPath, IndexPath) {
        DebugPrint("away: \(away)")
        DebugPrint("home: \(home)")
        let array = Score.map(home: home, away: away)
        let lastDigitHome = homeScore%10
        let lastDigitAway = awayScore%10
        var idxRow = 0
        if let indexOfRow = home.firstIndex(where: { (current) -> Bool in
            if current == lastDigitHome {
                return true
            }
            return false
        }) {
            idxRow = indexOfRow+1
        }
        var idxSection = 0
        if let indexOfSection = away.firstIndex(where: { (current) -> Bool in
            if current == lastDigitAway {
                return true
            }
            return false
        }) {
            idxSection = indexOfSection+1
        }
        var pos = 1
        for score in array {
            if score.awayScore == lastDigitAway && score.homeScore == lastDigitHome {
                break
            }
            pos += 1
        }
        DebugPrint("pos: \(pos)")
//        let indexPath = IndexPath(row: idxRow, section: idxSection)
        let indexPath = IndexPath(row: idxSection, section: idxRow)
//        return (period, indexPath, pos, IndexPath(row: idxRow, section: 0), IndexPath(row: 0, section: idxSection))
        return (period, indexPath, pos, IndexPath(row: 0, section: idxRow), IndexPath(row: idxSection, section: 0))
    }
}
