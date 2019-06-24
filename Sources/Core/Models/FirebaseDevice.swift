//
//  FirebaseDevice.swift
//  Nudge
//
//  Created by Mark Evans on 10/24/18.
//  Copyright © 2018 Mark Evans. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import ObjectMapper

struct FirebaseDevice {
    var name: String
    var platform: String
    var token: String
    var userId: String

    init(name: String, platform: String, token: String, userId: String) {
        self.name = name
        self.platform = platform
        self.token = token
        self.userId = userId
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()

        guard let name = data["name"] as? String else {
            return nil
        }

        guard let platform = data["platform"] as? String else {
            return nil
        }

        guard let token = data["token"] as? String else {
            return nil
        }

        guard let userId = data["userId"] as? String else {
            return nil
        }

        self.name = name
        self.platform = platform
        self.token = token
        self.userId = userId
    }
}

extension FirebaseDevice: DatabaseRepresentation {
    var representation: [String : Any] {
        let rep: [String : Any] = [
            "name": name,
            "platform": platform,
            "token": token,
            "userId": userId
        ]
        return rep
    }
}

extension FirebaseDevice: Comparable {
    static func == (lhs: FirebaseDevice, rhs: FirebaseDevice) -> Bool {
        return lhs.token == rhs.token
    }

    static func < (lhs: FirebaseDevice, rhs: FirebaseDevice) -> Bool {
        return lhs.name < rhs.name
    }
}

struct FirebaseUser {
    var name: String?
    var profilePic: String?
    var userId: String

    init(name: String?, profilePic: String?, userId: String) {
        self.name = name
        self.profilePic = profilePic
        self.userId = userId
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        self.name = data["name"] as? String ?? nil
        self.profilePic = data["profilePic"] as? String ?? nil
        self.userId = data["userId"] as? String ?? ""
    }
}

extension FirebaseUser: DatabaseRepresentation {
    var representation: [String : Any] {
        let rep: [String : Any] = [
            "name": name ?? "",
            "profilePic": profilePic ?? "",
            "userId": userId
        ]
        return rep
    }
}

extension FirebaseUser: Comparable {
    static func == (lhs: FirebaseUser, rhs: FirebaseUser) -> Bool {
        return lhs.userId == rhs.userId
    }

    static func < (lhs: FirebaseUser, rhs: FirebaseUser) -> Bool {
        return lhs.name != nil && rhs.name != nil && lhs.name! < rhs.name!
    }
}
