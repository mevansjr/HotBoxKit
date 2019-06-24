//
//  Transaction.swift
//  HotBox
//
//  Created by Mark Evans on 12/6/18.
//  Copyright © 2018 Mark Evans. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

struct Transaction {

    var id: String?
    var amount: Int?
    var balance: Int?
    var createdDateTime: Timestamp
    var type: Int?
    var userId: String?

    var representation: [String : Any] {
        var rep: [String : Any] = [
            "createdDateTime": createdDateTime,
            ]
        if let id = id {
            rep["id"] = id
        }
        if let amount = amount {
            rep["amount"] = amount
        }
        if let balance = balance {
            rep["balance"] = balance
        }
        if let type = type {
            rep["type"] = type
        }
        if let userId = userId {
            rep["userId"] = userId
        }
        return rep
    }

    init(amount: Int, balance: Int, type: Int, userId: String) {
        self.id = nil
        self.amount = amount
        self.balance = balance
        self.createdDateTime = Timestamp(date: Date())
        self.type = type
        self.userId = userId
    }

    init?(doc: DocumentSnapshot) {
        let data = doc.data()

        self.id = doc.documentID

        if let amount = data?["amount"] as? Int {
            self.amount = amount
        }

        if let balance = data?["balance"] as? Int {
            self.balance = balance
        }

        if let type = data?["type"] as? Int {
            self.type = type
        }

        if let userId = data?["userId"] as? String {
            self.userId = userId
        }

        self.createdDateTime = Timestamp(date: Date())
        if let createdDateTime = data?["createdDateTime"] as? Timestamp {
            self.createdDateTime = createdDateTime
        }
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()

        self.id = document.documentID

        if let amount = data["amount"] as? Int {
            self.amount = amount
        }

        if let balance = data["balance"] as? Int {
            self.balance = balance
        }

        if let type = data["type"] as? Int {
            self.type = type
        }

        if let userId = data["userId"] as? String {
            self.userId = userId
        }

        self.createdDateTime = Timestamp(date: Date())
        if let createdDateTime = data["createdDateTime"] as? Timestamp {
            self.createdDateTime = createdDateTime
        }
    }
}

extension Transaction: Comparable {
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.createdDateTime == rhs.createdDateTime
    }

    static func < (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.createdDateTime.seconds > rhs.createdDateTime.seconds
    }
}

extension Transaction {
    static func add(amount: Int, type: Int, userId: String, completion: @escaping CompletionHandler) {
        let reference = Constants.shared.db.collection("transactions")
        var transaction = Transaction(amount: amount, balance: amount, type: type, userId: userId)
        var ref: DocumentReference? = nil
        ref = reference.addDocument(data: transaction.representation) { error in
            if let e = error {
                DispatchQueue.main.async {
                    completion(nil, NSError(domain: e.localizedDescription, code: 400, userInfo: nil))
                }
                return
            }
            else if let transactionId = ref?.documentID {
                transaction.id = transactionId
                DispatchQueue.main.async {
                    completion(transaction, nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
            }
        }
    }

    static func all(userId: String?, completion: @escaping CompletionHandler) {
        let _ = Constants.shared.db.collection("transactions")
            .whereField("userId", isEqualTo: userId ?? "")
            .addSnapshotListener { (snapshot, error) in
                guard let snapshot = snapshot else {
                    DispatchQueue.main.async {
                        completion([Transaction](), nil)
                    }
                    return
                }
                var transactions = [Transaction]()
                snapshot.documents.forEach({ (snap) in
                    if let transaction = Transaction(document: snap) {
                        transactions.append(transaction)
                    }
                })
                transactions = transactions.sorted()
                DispatchQueue.main.async {
                    completion(transactions, nil)
                }
        }
    }
}
