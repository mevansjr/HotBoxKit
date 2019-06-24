//
//  TransactionApi.swift
//  HotBox
//
//  Created by Mark Evans on 1/10/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//

import Foundation

class TransactionApi : NSObject, Mappable {
    var id: String?
    var amount : Int = 0
    var balance : Int = 0
    var type : Int?
    var userId: String?
    var createdDateTime : Double = Date().timeIntervalSince1970
    var createdDateTimeStamp: Double?
    var entryId: String?

    class func newInstance(_ map: Map) -> Mappable? {
        return TransactionApi()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map) {
        id <- map["id"]
        amount <- map["amount"]
        balance <- map["balance"]
        type <- map["type"]
        userId <- map["userId"]
        createdDateTime <- map["createdDateTime._seconds"]
        createdDateTimeStamp <- map["createdDateTimeStamp"]
        entryId <- map["entryId"]
    }
}

