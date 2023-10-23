//
//  toDosModel.swift
//  HW25
//
//  Created by Вадим Игнатенко on 23.10.23.
//

import Foundation

struct ToDos: Codable {
    let userId: Int
    let id: Int
    let title: String?
    let completed: Bool?
}
