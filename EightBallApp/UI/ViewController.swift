//
//  ViewController.swift
//  EightBallApp
//
//  Created by Aleksandr Moroshovskyi on 9/2/19.
//  Copyright © 2019 Aleksandr Moroshovskyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var navigation: UINavigationItem!
    
    var dataTask: URLSessionDataTask?
    
    @IBAction func refreshButton(_ sender: Any) {
        refresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }
    
    func refresh() {
        dataTask?.cancel()
        self.activityIndicator.isHidden = true
        self.label.text = "SHAKE THE PHONE"
    }
    
    func show(answer: String) {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.label.text = answer
    }
    
    private func getAnswer(completion: @escaping (ModelAnswer) -> Void) {
        dataTask = RequestManager.URLRequest {result, error in
            if let model = result {
                completion(model)
            } else {
                completion(ModelAnswer.getRandomAnswer())
            }
        }
    }
    
    //MARK: - Motions
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("* motionBegan")
        self.label.text = ""
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("* motionEnded")
        getAnswer { model in
            self.show(answer: model.answer)
        }
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("* motionCancelled")
        dataTask?.cancel()
    }
}
