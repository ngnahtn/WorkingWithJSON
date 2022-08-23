//
//  UserApiModel.swift
//  WorkingWithJSON
//
//  Created by admin on 22/08/2022.
//

import Foundation
import ObjectMapper

class UserAPIModel {
    
}

class UserModel: Mappable {
    var id = 0
    var name = ""
    var avatar = ""
    var email = ""
    var phone = ""
    
    required convenience  init?(map: Map) {
        self.init()
    }

    func mapping(map: Map)
    {
        id <- map["id"]
        name <- map["name"]
        avatar <- map["avatar"]
        email <- map["email"]
        phone <- map["phone"]
        
    }
}
