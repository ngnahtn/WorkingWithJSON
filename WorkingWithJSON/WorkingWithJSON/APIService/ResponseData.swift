//
//  ResponseData.swift
//  WorkingWithJSON
//
//  Created by admin on 22/08/2022.
//

import Foundation
import ObjectMapper

class ResponseData: NSObject {
    static var shared = ResponseData()

    func getUser(page: Int,limit:Int, completion: @escaping ( _ data: [UserModel]) -> ()) {
        
        let param = [
            "page" : page,
            "limit" : limit
        ]
        
        APIClient.shared.requestDataGet(url: API.shared.person, method: .get, params: param) { result in
            var data: [UserModel] = []
            for item in result {
                let user = UserModel(JSON: item)!
                data.append(user)
            }
            completion(data)
        }
    }
    
    func getUserOffline(completion: @escaping ( _ data: [UserModel]) -> ()) {
        APIClient.shared.getOfflineData { result in
            var data: [UserModel] = []
            for item in result {
                let user = UserModel(JSON: item)!
                data.append(user)
            }
            completion(data)
        }
    }
}
