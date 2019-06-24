//
//  DurationPresetApi.swift
//  HotBox
//
//  Created by Mark Evans on 5/23/19.
//  Copyright © 2019 Mark Evans. All rights reserved.
//

import Foundation

class DurationPresetApi : NSObject, Mappable {
    var name : String?
    var minutes : Int = 15

    class func newInstance(_ map: Map) -> Mappable? {
        return DurationPresetApi()
    }
    required init?(map: Map){}
    override init(){}

    func mapping(map: Map) {
        name <- map["name"]
        minutes <- map["minutes"]
    }
}

extension DurationPresetApi {
    var shortName: String {
        if let name = self.name {
            var name_ = name
            if name.lowercased().contains("mintues") {
                name_ = name_.replacingOccurrences(of: "Minutes", with: "MINS")
            }
            else if name.lowercased().contains("minute") {
                name_ = name_.replacingOccurrences(of: "Minute", with: "MIN")
            }
            return name_.uppercased()
        }
        return self.name ?? ""
    }
}
