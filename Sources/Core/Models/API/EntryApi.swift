//
//  EntryApi.swift
//  HotBox
//
//  Created by Mark Evans on 1/10/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//

import Foundation

class EntryApi : NSObject, Mappable {
    var entryFee : Int = 0
    var boxNumber : Int = 0
    var userId : String?
    var userName : String?
    var status : Int = 0
    var isForSale : Bool = false
    var salePrice : Int = 0

    class func newInstance(_ map: Map) -> Mappable? {
        return EntryApi()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map) {
        entryFee <- map["entryFee"]
        boxNumber <- map["boxNumber"]
        userId <- map["userId"]
        userName <- map["userName"]
        status <- map["status"]
        isForSale <- map["isForSale"]
        salePrice <- map["salePrice"]
    }
}
