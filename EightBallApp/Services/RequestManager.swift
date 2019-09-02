//
//  RequestManager.swift
//  EightBallApp
//
//  Created by Aleksandr Moroshovskyi on 9/2/19.
//  Copyright © 2019 Aleksandr Moroshovskyi. All rights reserved.
//

import Foundation

class RequestManager: NSObject {
    class func URLRequest(completion: @escaping (_ result: ModelAnswer?, _ error: Error?) -> Void) -> URLSessionDataTask? {
        let url = URL(string: Constants.kBaseURL)
        
        if url == nil {
            print("Wrong url")
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
                DispatchQueue.main.async {
                    completion(nil, error!)
                }
            } else {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : AnyObject]
                        
                        if let magic = json["magic"] {
                            let jsonAnswer = magic["answer"] as? String
                            let modelAnswer = ModelAnswer.init(answer: jsonAnswer!)
                            DispatchQueue.main.async {
                                completion(modelAnswer, nil)
                            }
                        }
                    } catch let jsonError {
                        print(jsonError)
                    }
                } else {
                    print("data is empty !!!")
                    DispatchQueue.main.async {
                        completion(nil, nil)
                    }
                }
            }
        }
        task.resume()
        return task
    }
}
