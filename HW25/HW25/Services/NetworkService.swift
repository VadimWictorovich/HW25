//
//  NetworkService.swift
//  HW25
//
//  Created by Вадим Игнатенко on 17.10.23.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkService {
    static func deletePost(postId: Int, callback: @escaping () -> ()) {
           let urlPath = "\(ApiConstants.postsPath)/\(postId)"
            AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
            .response { response in
                callback()
        }
    }
}

