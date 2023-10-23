//
//  CacheManager.swift
//  HW25
//
//  Created by Вадим Игнатенко on 23.10.23.
//

import Foundation
import Alamofire
import AlamofireImage


class CacheManager {
    
    private init () {}
    static let shared = CacheManager()
    let imageCache = AutoPurgingImageCache(memoryCapacity: 100_000_000, preferredMemoryUsageAfterPurge: 50_000_000)
}
