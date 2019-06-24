//
//  TransactionUI.swift
//  HotBox
//
//  Created by Erik Uecke on 5/22/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//

import Foundation
import UIKit

class TransactionUI: NSObject, Mappable {
    var balanceText : String?
    var amountTextColor: UIColor?
    var amountText: String?
    var transactionDescription: String?
    var dateText: String?
    
    class func newInstance(_ map: Map) -> Mappable? {
        return TransactionUI()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map) {
        balanceText <- map["balanceText"]
        amountTextColor <- map["amountTextColor"]
        amountText <- map["amountText"]
        transactionDescription <- map["transactionDescription"]
        dateText <- map["dateText"]
    }
}
