//
//  Competition.swift
//  HotBox
//
//  Created by Mark Evans on 1/7/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

struct Competition {

    var id: String?
    var name: String
    var numPeriods: Int
    var organizationId: String
    var organizationRef: DocumentReference?
    var periodNamePrefix: String
    var sportId: String
    var sportRef: DocumentReference?

    var representation: [String : Any] {
        var rep: [String : Any] = [
            "name": name,
            "numPeriods": numPeriods,
            "organizationId": organizationId,
            "periodNamePrefix": periodNamePrefix,
            "sportId": sportId,
            ]
        if let organizationRef = organizationRef {
            rep["organizationRef"] = organizationRef
        }
        if let sportRef = sportRef {
            rep["sportRef"] = sportRef
        }
        if let id = id {
            rep["id"] = id
        }
        return rep
    }

    init(name: String, numPeriods: Int, organizationId: String, sportId: String, periodNamePrefix: String) {
        self.id = nil
        self.name = name
        self.numPeriods = numPeriods
        self.organizationId = organizationId
        self.organizationRef = Constants.shared.db.collection("organizations").document(organizationId)
        self.sportId = sportId
        self.sportRef = Constants.shared.db.collection("sports").document(sportId)
        self.periodNamePrefix = periodNamePrefix
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data(with: ServerTimestampBehavior.estimate)

        self.id = document.documentID

        if let organizationRef = data["organizationRef"] as? DocumentReference {
            self.organizationRef = organizationRef
        }

        if let sportRef = data["sportRef"] as? DocumentReference {
            self.sportRef = sportRef
        }

        guard let name = data["name"] as? String else {
            return nil
        }

        self.name = name

        guard let numPeriods = data["numPeriods"] as? Int else {
            return nil
        }

        self.numPeriods = numPeriods

        guard let organizationId = data["organizationId"] as? String else {
            return nil
        }

        self.organizationId = organizationId

        guard let sportId = data["sportId"] as? String else {
            return nil
        }

        self.sportId = sportId

        guard let periodNamePrefix = data["periodNamePrefix"] as? String else {
            return nil
        }

        self.periodNamePrefix = periodNamePrefix
    }
}

extension Competition: Comparable {
    static func == (lhs: Competition, rhs: Competition) -> Bool {
        return lhs.name == rhs.name
    }

    static func < (lhs: Competition, rhs: Competition) -> Bool {
        return lhs.name < rhs.name
    }
}
