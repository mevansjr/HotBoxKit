//
//
//  SecureKeys.swift
//
//  Created by Mark Evans on 2/22/17.
//  Copyright © 2017 3Advance, LLC. All rights reserved.
//

import Foundation

@objc public class SecureKeys: NSObject {

    public var FirebaseSenderID = ""
    public var FirebaseApiEndpoint = ""
    public var FirebaseAcessToken = ""
    
    public static let shared: SecureKeys = {
        let instance = SecureKeys()
        return instance
    }()
    
}
