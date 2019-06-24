//
//  FirebaseDevice.swift
//  Nudge
//
//  Created by Mark Evans on 10/24/18.
//  Copyright © 2018 Mark Evans. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import FirebaseUI

struct User {
    var id: String?
    var firstName: String
    var lastName: String
    var authUserId: String?
    var balance: Int?
    var isBot: Bool

    var representation: [String : Any] {
        var rep: [String : Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "isBot": isBot
        ]
        if let id = id {
            rep["id"] = id
        }
        if let authUserId = authUserId {
            rep["authUserId"] = authUserId
        }
        if let balance = balance {
            rep["balance"] = balance
        }
        return rep
    }

    init(firstName: String, lastName: String, authUserId: String?, isBot: Bool) {
        self.id = nil
        self.firstName = firstName
        self.lastName = lastName
        self.authUserId = authUserId
        self.balance = nil
        self.isBot = isBot
    }

    init?(doc: DocumentSnapshot) {
        let data = doc.data()

        self.id = doc.documentID
        self.balance = 0

        guard let firstName = data?["firstName"] as? String else {
            return nil
        }

        guard let lastName = data?["lastName"] as? String else {
            return nil
        }

        guard let authUserId = data?["authUserId"] as? String else {
            return nil
        }

        if let balance = data?["balance"] as? Int {
            self.balance = balance
        }

        guard let isBot = data?["isBot"] as? Bool else {
            return nil
        }

        self.firstName = firstName
        self.lastName = lastName
        self.authUserId = authUserId
        self.isBot = isBot
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()

        self.id = document.documentID
        self.balance = 0

        guard let firstName = data["firstName"] as? String else {
            return nil
        }

        guard let lastName = data["lastName"] as? String else {
            return nil
        }

        guard let authUserId = data["authUserId"] as? String else {
            return nil
        }

        if let balance = data["balance"] as? Int {
            self.balance = balance
        }

        guard let isBot = data["isBot"] as? Bool else {
            return nil
        }

        self.firstName = firstName
        self.lastName = lastName
        self.authUserId = authUserId
        self.isBot = isBot
    }
}

extension User: Comparable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.lastName == rhs.lastName
    }

    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.lastName < rhs.lastName
    }
}

extension User {
    static func addUser(firstName: String, lastName: String, authUserId: String, completion: @escaping CompletionHandler) {
        var userReference: CollectionReference {
            return Constants.shared.db.collection("users")
        }
        let user = User(firstName: firstName, lastName: lastName, authUserId: authUserId, isBot: false)
        var ref: DocumentReference? = nil
        ref = userReference.addDocument(data: user.representation) { error in
            if let e = error {
                DispatchQueue.main.async {
                    completion(nil, NSError(domain: e.localizedDescription, code: 400, userInfo: nil))
                }
                return
            }
            else if let userId = ref?.documentID {
                DispatchQueue.main.async {
                    completion(userId, nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil, NSError(domain: Constants.DEFAULT_ERROR_MSG, code: 400, userInfo: nil))
            }
        }
    }

    static func get(authUserId: String, completion: @escaping CompletionHandler) {
        var userReference: CollectionReference {
            return Constants.shared.db.collection("users")
        }
        userReference.whereField("authUserId", isEqualTo: authUserId).getDocuments { (snapshot, error) in
            var user: User?
            guard let snapshot = snapshot else {
                DispatchQueue.main.async {
                    completion(user, nil)
                }
                return
            }
            if let doc = snapshot.documents.first, let usr = User(document: doc) {
                Constants.shared.currentUser = usr
                if let ref = User.userProfileRef {
                    ref.downloadURL(completion: { (url, nil) in
                        if let profileUrl = url {
                            SDWebImageDownloader.shared().downloadImage(with: profileUrl, options: SDWebImageDownloaderOptions.highPriority, progress: nil, completed: { (image, _, _, _) in
                                if let img = image {
                                    Constants.shared.profileImage = img
                                    NotificationCenter.default.userPicChanged()
                                }
                            })
                        }
                    })
                }
                user = usr
            }
            DispatchQueue.main.async {
                completion(user, nil)
            }
        }
//        userReference.document(userId).getDocument { (snapshot, error) in
//            var user: User?
//            guard let snapshot = snapshot else {
//                DispatchQueue.main.async {
//                    completion(user, nil)
//                }
//                return
//            }
//            if let usr = User(doc: snapshot) {
//                user = usr
//            }
//            DispatchQueue.main.async {
//                completion(user, nil)
//            }
//        }
    }

    static func botUsers(count: Int, completion: @escaping CompletionHandler) {
        var userReference: CollectionReference {
            return Constants.shared.db.collection("users")
        }
        userReference.whereField("isBot", isEqualTo: true).limit(to: count).addSnapshotListener { (snapshot, error) in
            var users = [User]()
            guard let snapshot = snapshot else {
                DispatchQueue.main.async {
                     completion(users, nil)
                }
                return
            }
            snapshot.documentChanges.forEach { change in
                if let user = User(document: change.document), change.type == .added {
                    users.append(user)
                }
            }
            DispatchQueue.main.async {
                completion(users, nil)
            }
        }
    }

    static var userProfileRef: StorageReference? {
        guard let userId = Constants.shared.currentUserApi?.id else {
            return nil
        }
        let store = Storage.storage()
        let storeRef = store.reference()
        return storeRef.child("images/profiles").child("\(userId).png")
    }

    static func uploadProfilePic(image: UIImage, completion: @escaping CompletionBoolHandler) {
        guard let userId = Constants.shared.currentUserApi?.id else {
            DispatchQueue.main.async {
                completion(false)
            }
            return
        }
        var imageData: Data?
        let resizedImage = image.resizeImage(width: 600)
        if let imgJpgData = resizedImage.squareCrop(600).jpegData(compressionQuality: 0.2) {
            if let compressedImage = UIImage(data: imgJpgData, scale: 1) {
                if let imgPngData = compressedImage.pngData() {
                    imageData = imgPngData
                }
            }
        }
        guard let data = imageData else {
            DispatchQueue.main.async {
                completion(false)
            }
            return
        }
        let store = Storage.storage()
        let storeRef = store.reference()
        let userProfilesRef = storeRef.child("images/profiles").child("\(userId).png")
        userProfilesRef.putData(data, metadata: nil) { (metadata, error) in
            guard let _ = metadata else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            DispatchQueue.main.async {
                completion(true)
            }
        }
    }

    var nameDescription: String {
        if let firstCharacter = self.firstName.first {
            return "\(String(firstCharacter)) \(self.lastName))"
        }
        return "\(self.firstName) \(self.lastName)"
    }
}
