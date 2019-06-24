//
//  HotBoxKit.swift
//  HotBoxKit
//
//  Created by Mark Evans on Jun 21, 2019.
//  Copyright © 2019 3Advance LLC. All rights reserved.
//

// Include Foundation
@_exported import Foundation
@_exported import FirebaseFirestore
@_exported import FirebaseMessaging
@_exported import FirebaseAuth
@_exported import FirebaseStorage
@_exported import FirebaseDatabase
@_exported import FirebaseCore

public class HotBoxKit {
    public var config: HotBoxConfig?

    public static let shared: HotBoxKit = {
        let instance = HotBoxKit()
        return instance
    }()

    @discardableResult public init(withConfig config: HotBoxConfig? = nil) {
        self.config = config
        SecureKeys.shared.FirebaseAcessToken = self.config?.accessToken ?? ""
        SecureKeys.shared.FirebaseSenderID = self.config?.senderId ?? ""
        SecureKeys.shared.FirebaseApiEndpoint = self.config?.apiEndpoint ?? ""
        debugLog()
    }

    private func debugLog() {
        print("\n******************************************************************")
        print(">> HotBoxKit Module")
        print("******************************************************************")
        print(">> FirebaseSenderID: \(SecureKeys.shared.FirebaseSenderID)")
        print(">> FirebaseApiEndpoint: \(SecureKeys.shared.FirebaseApiEndpoint)")
        print(">> FirebaseAcessToken: \(SecureKeys.shared.FirebaseAcessToken)")
        print("******************************************************************\n")
    }
}

public struct HotBoxConfig {
    public var accessToken: String
    public var senderId: String
    public var apiEndpoint: String
    public init(accessToken: String, senderId: String, apiEndpoint: String) {
        self.accessToken = accessToken;
        self.senderId = senderId;
        self.apiEndpoint = apiEndpoint;
    }
}
