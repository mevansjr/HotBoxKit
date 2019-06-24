//
//  Token.swift
//  Base
//
//  Created by Mark Evans on 6/27/17.
//  Copyright © 2017 3Advance, LLC. All rights reserved.
//

import Foundation

class TokenBase: NSObject, Mappable {
    public static let tokenKey = "TokenKey"

    var accessToken: String?
    var tokenType: String?
    var expiresIn: Float = 0
    var refreshToken: String?

    class func newInstance(_ map: Map) -> Mappable? {
        return TokenBase()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map) {
        accessToken <- map["access_token"]
        tokenType <- map["token_type"]
        expiresIn <- map["expires_in"]
        refreshToken <- map["refresh_token"]
    }
}
