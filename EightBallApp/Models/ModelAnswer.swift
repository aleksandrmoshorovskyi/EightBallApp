//
//  ModelAnswer.swift
//  EightBallApp
//
//  Created by Aleksandr Moroshovskyi on 9/2/19.
//  Copyright © 2019 Aleksandr Moroshovskyi. All rights reserved.
//

import Foundation

class ModelAnswer: NSObject {
    let answer: String
    
    init(answer: String) {
        self.answer = answer
    }
    
    class func getRandomAnswer() -> ModelAnswer {
        var randomAnswer = ""
        let data = DataManager.fetchData(type: Magic.self)
        if let array = data.array {
            if array.count > 0 {
                let number = Int.random(in: 0..<array.count)
                
                if let answer = array[number].answer {
                    randomAnswer = answer
                }
            } else {
                randomAnswer = "Please add default answers in settings..."
            }
        } else if let error = data.error {
            print("No data\(error)", error.userInfo)
            randomAnswer = "Oops..."
        }
        
        return ModelAnswer.init(answer: randomAnswer)
    }
}
