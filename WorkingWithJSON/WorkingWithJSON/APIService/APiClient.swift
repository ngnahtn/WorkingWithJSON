//
//  APiClient.swift
//  WorkingWithJSON
//
//  Created by admin on 22/08/2022.
//

import UIKit
import Alamofire
import UIAlertView_Blocks
import PKHUD
import ObjectMapper
// for check internet
struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}

class APIClient: NSObject {
    static var shared = APIClient()
    
    func getOfflineData(completion: @escaping (_ result: [[String:Any]]) -> ()) {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            completion([[:]])
            return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let result = jsonResult as? [[String: Any]] {
                completion(result)
            }
        } catch {
            completion([[:]])
            print("Load JSON OFFLine error")
        }
    }

    func requestDataGet(url:String,method:HTTPMethod,params: Parameters!,completion: @escaping (_ result:[[String:Any]]) -> ())  {

        if Connectivity.isConnectedToInternet {
            let headers: HTTPHeaders = [
                .authorization(bearerToken: ""),
                .accept("application/json")
            ]

            AF.sessionConfiguration.timeoutIntervalForRequest = 120
            
            let urlString = "\(API.shared.HostServer)\(url)"
            guard let path = URL(string: urlString) else {
                return
            }
            
            AF.request(path, method: method, parameters: params, encoding: URLEncoding.default, headers: headers).validate(statusCode: 0 ..< 999).responseData { AFdata in
                switch AFdata.result {
                case .success(let value):
                    let responseObj = try? JSONSerialization.jsonObject(with: value, options: [])
                    if let dict = responseObj as? [[String:Any]] {
                        print(dict)
                        completion(dict)
                    }
                    else
                    {
                        let data: [[String: Any]] = [[:]]
                        completion(data)
                        self.showAlert(message: "Lỗi dữ liệu")
                    }
                case .failure(let error):
                    print(error)
                    let data: [[String: Any]] = [[:]]
                    
                    if error.localizedDescription.contains("timed out") {
                        self.showAlert(message: "Mất kết nối mạng, vui lòng kiểm tra lại.")
                    }
                    else{
                        self.showAlert(message: error.localizedDescription)
                    }
                    completion(data)
                }
            }
         } else {
             print("No Internet")
             let data: [[String: Any]] = [[:]]
            self.showAlert(message: "Bạn vui lòng kiểm tra kết nối mạng.")
            completion(data)
            
        }
        
    }
}

extension APIClient {
    func showAlert(message: String) {
        if #available(iOS 8, *) {
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "OK",
                                         style: .default,
                                         handler: nil)
            alertController.addAction(actionOk)
            if let app = UIApplication.shared.delegate as? AppDelegate {
                app.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            }
        }
        else {
            let alertView = UIAlertView(title: "", message: message, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK")
            alertView.show()
        }
    }

}

