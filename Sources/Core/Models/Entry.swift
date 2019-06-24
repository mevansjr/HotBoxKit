//
//  Entry.swift
//  HotBox
//
//  Created by Mark Evans on 12/5/18.
//  Copyright © 2018 Mark Evans. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

struct Entry {
    var id: String?
    var boxNumber: Int
    var entryFee: Int
    var userId: String
    var name: String
    var status: Int = 1
    var awayScore: Int = 0
    var homeScore: Int = 0
    var history: [EntryHistory]?
    var isForSale: Bool?
    var salePrice: Int?

    var representation: [String : Any] {
        var rep: [String : Any] = [
            "boxNumber": boxNumber,
            "entryFee": entryFee,
            "userId": userId,
            "name": name,
            "status": status,
            "awayScore": awayScore,
            "homeScore": homeScore
        ]
        if let id = id {
            rep["id"] = id
        }
        if let history = history {
            rep["history"] = history
        }
        if let isForSale = isForSale {
            rep["isForSale"] = isForSale
        }
        if let salePrice = salePrice {
            rep["salePrice"] = salePrice
        }
        return rep
    }

    init(entryId: String, boxNumber: Int, entryFee: Int, userId: String, name: String, isForSale: Bool?, salePrice: Int?, status: Int, awayScore: Int, homeScore: Int) {
        self.id = entryId
        self.history = nil
        self.isForSale = isForSale
        self.salePrice = salePrice
        self.boxNumber = boxNumber
        self.entryFee = entryFee
        self.userId = userId
        self.name = name
        self.status = status
        self.awayScore = awayScore
        self.homeScore = homeScore
    }

    init?(doc: DocumentSnapshot) {
        let data = doc.data()

        self.id = doc.documentID

        guard let boxNumber = data?["boxNumber"] as? Int else {
            return nil
        }

        guard let entryFee = data?["entryFee"] as? Int else {
            return nil
        }

        guard let userId = data?["userId"] as? String else {
            return nil
        }

        guard let name = data?["name"] as? String else {
            return nil
        }

        guard let status = data?["status"] as? Int else {
            return nil
        }

        guard let awayScore = data?["awayScore"] as? Int else {
            return nil
        }

        guard let homeScore = data?["homeScore"] as? Int else {
            return nil
        }

        if let history = data?["history"] as? [[String: Any]] {
            var array = [EntryHistory]()
            history.forEach { (dict) in
                if
                    let amount = dict["amount"] as? Int,
                    let buyerUserId = dict["buyerUserId"] as? String,
                    let dateEpoch = dict["dateEpoch"] as? Double,
                    let type = dict["type"] as? String
                {
                    array.append(EntryHistory(amount: amount, buyerUserId: buyerUserId, dateEpoch: dateEpoch, type: type))
                }
            }
            self.history = array
        }

        if let salePrice = data?["salePrice"] as? Int {
            self.salePrice = salePrice
        }

        if let isForSale = data?["isForSale"] as? Bool {
            self.isForSale = isForSale
        }

        self.boxNumber = boxNumber
        self.entryFee = entryFee
        self.userId = userId
        self.awayScore = awayScore
        self.homeScore = homeScore
        self.name = name
        self.status = status
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()

        self.id = document.documentID

        guard let boxNumber = data["boxNumber"] as? Int else {
            return nil
        }

        guard let entryFee = data["entryFee"] as? Int else {
            return nil
        }

        guard let userId = data["userId"] as? String else {
            return nil
        }

        guard let awayScore = data["awayScore"] as? Int else {
            return nil
        }

        guard let homeScore = data["homeScore"] as? Int else {
            return nil
        }

        guard let name = data["name"] as? String else {
            return nil
        }

        guard let status = data["status"] as? Int else {
            return nil
        }

        if let history = data["history"] as? [[String: Any]] {
            var array = [EntryHistory]()
            history.forEach { (dict) in
                if
                    let amount = dict["amount"] as? Int,
                    let buyerUserId = dict["buyerUserId"] as? String,
                    let dateEpoch = dict["dateEpoch"] as? Double,
                    let type = dict["type"] as? String
                {
                    array.append(EntryHistory(amount: amount, buyerUserId: buyerUserId, dateEpoch: dateEpoch, type: type))
                }
            }
            self.history = array
        }

        if let salePrice = data["salePrice"] as? Int {
            self.salePrice = salePrice
        }

        if let isForSale = data["isForSale"] as? Bool {
            self.isForSale = isForSale
        }

        self.boxNumber = boxNumber
        self.entryFee = entryFee
        self.userId = userId
        self.awayScore = awayScore
        self.homeScore = homeScore
        self.name = name
        self.status = status
    }
}

extension Entry: Comparable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.boxNumber == rhs.boxNumber
    }

    static func < (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.boxNumber < rhs.boxNumber
    }
}

extension Entry {
    var awayHome: String {
        return "\(awayScore)-\(homeScore)"
    }
}

struct EntryHistory {

    var amount: Int
    var buyerUserId: String
    var dateEpoch: Double = Date().timeIntervalSince1970
    var type: String

    var representation: [String : Any] {
        let rep: [String : Any] = [
            "amount": amount,
            "buyerUserId": buyerUserId,
            "dateEpoch": dateEpoch,
            "type": type,
            ]
        return rep
    }

    init(amount: Int, buyerUserId: String, dateEpoch: Double, type: String) {
        self.amount = amount
        self.buyerUserId = buyerUserId
        self.dateEpoch = dateEpoch
        self.type = type
    }

    init?(doc: DocumentSnapshot) {
        let data = doc.data()

        guard let amount = data?["amount"] as? Int else {
            return nil
        }

        guard let buyerUserId = data?["buyerUserId"] as? String else {
            return nil
        }

        guard let dateEpoch = data?["dateEpoch"] as? Double else {
            return nil
        }

        guard let type = data?["type"] as? String else {
            return nil
        }

        self.amount = amount
        self.buyerUserId = buyerUserId
        self.dateEpoch = dateEpoch
        self.type = type
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()

        guard let amount = data["amount"] as? Int else {
            return nil
        }

        guard let buyerUserId = data["buyerUserId"] as? String else {
            return nil
        }

        guard let dateEpoch = data["dateEpoch"] as? Double else {
            return nil
        }

        guard let type = data["type"] as? String else {
            return nil
        }

        self.amount = amount
        self.buyerUserId = buyerUserId
        self.dateEpoch = dateEpoch
        self.type = type
    }
}

extension EntryHistory: Comparable {
    static func == (lhs: EntryHistory, rhs: EntryHistory) -> Bool {
        return lhs.dateEpoch == rhs.dateEpoch
    }

    static func < (lhs: EntryHistory, rhs: EntryHistory) -> Bool {
        return lhs.dateEpoch < rhs.dateEpoch
    }
}

extension Entry {
//    static func add(pool: Pool, boxNumber: Int, entryFee: Int, name: String, userId: String, status: Int, completion: @escaping CompletionHandler) {
//        let db = Constants.shared.db
//        guard let id = pool.id else {
//            return
//        }
//        let reference = db.collection("pools").document(id).collection("entries")
//        var entry = Entry(boxNumber: boxNumber, entryFee: entryFee, userId: userId, name: name, status: status)
//        var ref: DocumentReference? = nil
//        ref = reference.addDocument(data: entry.representation) { error in
//            if let e = error {
//                DispatchQueue.main.async {
//                    completion(nil, NSError(domain: e.localizedDescription, code: 400, userInfo: nil))
//                }
//                return
//            }
//            else if let entryId = ref?.documentID {
//                entry.id = entryId
//                var data = [String: Any]()
//                data["userRef"] = db.collection("users").document(userId)
//                ref?.updateData(data)
//                DispatchQueue.main.async {
//                    completion(entry, nil)
//                }
//                return
//            }
//            DispatchQueue.main.async {
//                completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
//            }
//        }
//    }

    var nameDescription: String {
        let set = self.name.components(separatedBy: " ")
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
        return self.name
    }

    var nameDescriptionShort: String {
        let set = self.name.components(separatedBy: " ")
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
            if let firstCharacter = firstName.first, let lastCharacter = lastName.first {
                return "\(String(firstCharacter))\(String(lastCharacter))".uppercased()
            }
        }
        return self.name
    }

    var entryOrForSaleFee: Int {
        var fee = self.entryFee
        if let isForSale = self.isForSale, let salePrice = self.salePrice, isForSale {
            fee = salePrice
        }
        return fee
    }
}

extension Entry {
    var box: Int? {
        var box = self.boxNumber
        if let entryId = self.id {
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
