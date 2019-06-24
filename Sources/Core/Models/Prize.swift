//
//  Prize.swift
//  HotBox
//
//  Created by Mark Evans on 12/10/18.
//  Copyright © 2018 Mark Evans. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

struct Prize {

    var amount: Int?
    var name: String?
    var sortOrder: Int?
    var userId: String?
    var entryId: String?
    var boxNumber: Int?
    var rake: Int?
    var prizeAmount: Int?
    var userName: String?

    var representation: [String : Any] {
        var rep = [String : Any]()
        if let amount = amount {
            rep["amount"] = amount
        }
        if let name = name {
            rep["name"] = name
        }
        if let sortOrder = sortOrder {
            rep["sortOrder"] = sortOrder
        }
        if let userId = userId {
            rep["userId"] = userId
        }
        if let entryId = entryId {
            rep["entryId"] = entryId
        }
        if let boxNumber = boxNumber {
            rep["boxNumber"] = boxNumber
        }
        if let rake = rake {
            rep["rake"] = rake
        }
        if let prizeAmount = prizeAmount {
            rep["prizeAmount"] = prizeAmount
        }
        if let userName = userName {
            rep["userName"] = userName
        }
        return rep
    }

    init(amount: Int, name: String, sortOrder: Int, userId: String?, entryId: String?, boxNumber: Int?, userName: String?, rake: Int?, prizeAmount: Int?) {
        self.amount = amount
        self.name = name
        self.sortOrder = sortOrder
        self.userId = userId
        self.entryId = entryId
        self.boxNumber = boxNumber
        self.userName = userName
        self.rake = rake
        self.prizeAmount = prizeAmount
    }

    init?(doc: DocumentSnapshot?) {
        let data = doc?.data()

        if let amount = data?["amount"] as? Int {
            self.amount = amount
        }

        if let name = data?["name"] as? String {
            self.name = name
        }

        if let sortOrder = data?["sortOrder"] as? Int {
            self.sortOrder = sortOrder
        }

        if let userId = data?["userId"] as? String {
            self.userId = userId
        }

        if let entryId = data?["entryId"] as? String {
            self.entryId = entryId
        }

        if let boxNumber = data?["boxNumber"] as? Int {
            self.boxNumber = boxNumber
        }

        if let rake = data?["rake"] as? Int {
            self.rake = rake
        }

        if let prizeAmount = data?["prizeAmount"] as? Int {
            self.prizeAmount = prizeAmount
        }

        if let userName = data?["userName"] as? String {
            self.userName = userName
        }
    }

    init?(doc: DocumentSnapshot) {
        let data = doc.data()

        if let amount = data?["amount"] as? Int {
            self.amount = amount
        }

        if let name = data?["name"] as? String {
            self.name = name
        }

        if let sortOrder = data?["sortOrder"] as? Int {
            self.sortOrder = sortOrder
        }

        if let userId = data?["userId"] as? String {
            self.userId = userId
        }

        if let entryId = data?["entryId"] as? String {
            self.entryId = entryId
        }

        if let boxNumber = data?["boxNumber"] as? Int {
            self.boxNumber = boxNumber
        }

        if let rake = data?["rake"] as? Int {
            self.rake = rake
        }

        if let prizeAmount = data?["prizeAmount"] as? Int {
            self.prizeAmount = prizeAmount
        }

        if let userName = data?["userName"] as? String {
            self.userName = userName
        }
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()

        if let amount = data["amount"] as? Int {
            self.amount = amount
        }

        if let name = data["name"] as? String {
            self.name = name
        }

        if let sortOrder = data["sortOrder"] as? Int {
            self.sortOrder = sortOrder
        }

        if let userId = data["userId"] as? String {
            self.userId = userId
        }

        if let entryId = data["entryId"] as? String {
            self.entryId = entryId
        }

        if let boxNumber = data["boxNumber"] as? Int {
            self.boxNumber = boxNumber
        }

        if let rake = data["rake"] as? Int {
            self.rake = rake
        }

        if let prizeAmount = data["prizeAmount"] as? Int {
            self.prizeAmount = prizeAmount
        }

        if let userName = data["userName"] as? String {
            self.userName = userName
        }
    }
}

extension Prize: Comparable {
    static func == (lhs: Prize, rhs: Prize) -> Bool {
        return lhs.name == rhs.name
    }

    static func < (lhs: Prize, rhs: Prize) -> Bool {
        return lhs.name != nil && rhs.name != nil && lhs.name! < rhs.name!
    }
}

extension Prize {
    var nameDescription: String {
        if let name = self.userName {
            let set = name.components(separatedBy: " ")
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
        }
        return self.userName ?? ""
    }
}
