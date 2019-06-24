//
//
//  Secure.swift
//
//  Created by Mark Evans on 2/22/17.
//  Copyright © 2017 3Advance, LLC. All rights reserved.
//

import Foundation
import HotBoxKit

@objc public class Secure: NSObject {
    
    let FirebaseSenderID = "159718753959"
    let FirebaseApiEndpoint = "https://us-central1-hotbox-dev-8e719.cloudfunctions.net"
    var FirebaseAcessToken = ""
    
    static let shared: Secure = {
        let instance = Secure()
        return instance
    }()
    
}
