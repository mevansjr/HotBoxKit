//
//  Team.swift
//  HotBox
//
//  Created by Mark Evans on 12/5/18.
//  Copyright © 2018 Mark Evans. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

struct Team {
    var id: String?
    var name: String
    var mascot: String
    var primaryColor: String?
    var secondaryColor: String?
    var textColor: String?

    var representation: [String : Any] {
        var rep: [String : Any] = [
            "name": name,
            "mascot": mascot,
        ]
        if let id = id {
            rep["id"] = id
        }
        if let primaryColor = primaryColor {
            rep["primaryColor"] = primaryColor
        }
        if let secondaryColor = secondaryColor {
            rep["secondaryColor"] = secondaryColor
        }
        if let textColor = textColor {
            rep["textColor"] = textColor
        }
        return rep
    }

    init(name: String, mascot: String, primaryColor: String?, secondaryColor: String?, textColor: String?) {
        self.id = nil
        self.name = name
        self.mascot = mascot
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.textColor = textColor
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()

        self.id = document.documentID

        guard let name = data["name"] as? String else {
            return nil
        }

        guard let mascot = data["mascot"] as? String else {
            return nil
        }

        if let primaryColor = data["primaryColor"] as? String {
            self.primaryColor = primaryColor
        }

        if let secondaryColor = data["secondaryColor"] as? String {
            self.secondaryColor = secondaryColor
        }

        if let textColor = data["textColor"] as? String {
            self.textColor = textColor
        }

        self.name = name
        self.mascot = mascot
    }
}

extension Team: Comparable {
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.name == rhs.name
    }

    static func < (lhs: Team, rhs: Team) -> Bool {
        return lhs.name < rhs.name
    }
}

extension Team {
    static func findTeam(name: String, completion: @escaping CompletionHandler) {
        let teamReference = Constants.shared.db.collection("teams")
        teamReference.whereField("name", isEqualTo: name).limit(to: 1).getDocuments(completion: { (teamQuerySnap, error) in
            guard let teamQuerySnap = teamQuerySnap else {
                DispatchQueue.main.async {
                    completion(nil, NSError(domain: "\(error?.localizedDescription ?? "No error")", code: 400, userInfo: nil))
                }
                return
            }
            if let doc = teamQuerySnap.documents.first, let team = Team(document: doc) {
                DispatchQueue.main.async {
                    completion(team, nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
            }
        })
    }
}
