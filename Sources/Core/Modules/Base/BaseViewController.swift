//
//  BaseViewController.swift
//  HotBoxKit-iOS
//
//  Created by Mark Evans on 6/21/19.
//  Copyright © 2019 3Advance LLC. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

public class BaseViewController: UIViewController {

    private var poolReference: CollectionReference {
        return Firestore.firestore().collection("pools")
    }
    private var poolsListener: ListenerRegistration?
    var poolItems = [Pool]()

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Pool Listener

    func syncPools(pool: Pool) {

    }

    func addPoolListener(userId: String) {
        print("addPoolListener userId: \(userId) :: fired")
        self.poolsListener?.remove()
        self.poolsListener =
            poolReference
                .whereField("entryUserIds", arrayContains: userId)
                .addSnapshotListener { querySnapshot, error in
                    guard let snapshot = querySnapshot else {
                        print("Error listening for marketplaceListener updates: \(error?.localizedDescription ?? "No error")")
                        return
                    }
                    snapshot.documentChanges.forEach { change in
                        self.handlePoolsDocumentChange(change)
                    }
        }
    }

    func removePoolListener() {
        print("addPoolListener removePoolListener")
        self.poolsListener?.remove()
    }

    private func addPoolsInTable(_ pool: Pool) {
        guard !poolItems.contains(where: { (u) -> Bool in
            if u.id == pool.id {
                return true
            }
            return false
        }) else {
            return
        }
        poolItems.append(pool)
        poolItems.sort()
        self.syncPools(pool: pool)
    }

    private func updatePoolsInTable(_ pool: Pool) {
        if poolItems.count <= 0 {
            return
        }

        guard let index = poolItems.firstIndex(of: pool) else {
            return
        }

        poolItems[index] = pool
        poolItems.sort()
        self.syncPools(pool: pool)
    }

    private func removePoolsFromTable(_ pool: Pool) {
        if poolItems.count <= 0 {
            return
        }

        guard let index = poolItems.firstIndex(of: pool) else {
            return
        }

        poolItems.remove(at: index)
        poolItems.sort()
        self.syncPools(pool: pool)
    }

    private func handlePoolsDocumentChange(_ change: DocumentChange) {
        print("addPoolListener handlePoolsDocumentChange :: fired")
        guard let pool = Pool(document: change.document) else {
            return
        }

        switch change.type {
        case .added:
            addPoolsInTable(pool)

        case .modified:
            updatePoolsInTable(pool)

        case .removed:
            removePoolsFromTable(pool)
            
        @unknown default:
            print("unknown")
        }
    }
}
