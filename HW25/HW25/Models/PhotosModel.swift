//
//  PhotosModel.swift
//  HW25
//
//  Created by Вадим Игнатенко on 18.10.23.
//

import Foundation

struct Photos: Codable {
    let albumId: Int
    let id: Int
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
