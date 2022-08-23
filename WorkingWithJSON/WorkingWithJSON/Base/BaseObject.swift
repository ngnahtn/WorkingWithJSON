//
//  BaseObject.swift
//  CoLearn-Tutor
//
//  Created by Tuyen Nguyen on 26/07/2022.
//

import UIKit
import ObjectMapper

class BaseObject : Mappable{

    var message = ""
    var status = 0
    var total = 0

    required convenience  init?(map: Map) {
        self.init()
    }

    func mapping(map: Map)
    {
        message <- map["message"]
        status <- map["status"]
        total <- map["total"]
    }
}
