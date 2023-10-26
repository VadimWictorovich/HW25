//
//  CommentModel.swift
//  HW25
//
//  Created by Вадим Игнатенко on 18.10.23.
//

import Foundation

struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String?
    let email: String?
    let body: String?
}

