//
//  NewPostVC.swift
//  HW25
//
//  Created by Вадим Игнатенко on 17.10.23.
//

import Alamofire
import SwiftyJSON
import UIKit

class NewPostVC: UIViewController {
    @IBOutlet var titleTF: UITextField!
    @IBOutlet var bodyTV: UITextView!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }

    @IBAction func postURLSession() {
        guard let userId = user?.id,
              let title = titleTF.text,
              let body = bodyTV.text,
              let url = ApiConstants.postsURL else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let postBodyJSON: [String: Any] = [
            "userId": userId,
            "title": title,
            "body": body
        ]
        let httpBody = try? JSONSerialization.data(withJSONObject: postBodyJSON)
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { [weak self] data, response, _ in
            print(response)
            if let data = data {
                print(data)
                let json = JSON(data)
                print(json)
                let userId = json["userId"]
                let title = json["title"]
                let body = json["body"]
                DispatchQueue.main.async {
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }.resume()
    }
    
    @IBAction func postAlamofire() {
        if let userId = user?.id,
           let title = titleTF.text,
           let body = bodyTV.text,
           let url = ApiConstants.postsURL
        {
            let parameters: Parameters = [
                "userId": userId,
                "title": title,
                "body": body
            ]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .response { [weak self] response in
                    guard let self else { return }
                    print(response.request)
                    print(response.response)
                    
                    switch response.result {
                    case .success(let data):
                        print(data)
                        print(JSON(data))
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print(error)
                    }
                }
        }
    }
}
