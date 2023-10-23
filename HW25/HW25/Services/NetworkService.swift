//
//  NetworkService.swift
//  HW25
//
//  Created by Вадим Игнатенко on 17.10.23.
//

import UIKit
import Alamofire
import SwiftyJSON


class NetworkService {
    static func deletePost(postId: Int, callback: @escaping (_ result: JSON?, _ error: Error?) -> ()) {
           let urlPath = "\(ApiConstants.postsPath)/\(postId)"
            AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
            .response { response in
            var value: JSON?
            var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        callback(value, err)
                        return
                    }
                    value = JSON(data)
                case .failure(let error):
                    err = error
                }
                callback(value, err)
        }
    }
    
    static func fetchComments(postId: Int, callback: @escaping (_ result: [Comment]?, _ error: Error?) -> ()) {
        let urlPath = "\(ApiConstants.commentsPath)?postId=\(postId)"
        AF.request(urlPath, method: .get, encoding: JSONEncoding.default)
            .response { response in
                var comments: [Comment]?
                var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data else {
                        callback(comments, err)
                        return
                    }
                    print(JSON(data))
                    do {
                        comments = try JSONDecoder().decode([Comment].self, from: data)
                    } catch (let decodErr) {
                        print(decodErr)
                    }
                case .failure(let error):
                    err = error
                }
                callback(comments, err)
            }
    }
    
    static func fetchToDos(userId: Int, callback: @escaping (_ result: [ToDos]?, _ error: Error?) -> ()) {
        let urlPath = "\(ApiConstants.todosPath)?userId=\(userId)"
        AF.request(urlPath, method: .get, encoding: JSONEncoding.default)
            .response { response in
                var todos: [ToDos]?
                var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data else {
                        callback(todos, err)
                        return
                    }
                    print(JSON(data))
                    do {
                        todos = try JSONDecoder().decode([ToDos].self, from: data)
                    } catch (let decodErr) {
                        print(decodErr)
                    }
                case .failure(let error):
                    err = error
                }
                callback(todos, err)
            }
    }
    
    static func fetchAlboms(userId: Int, callback: @escaping (_ result: [Albom]?, _ error: Error?) -> ()) {
        let urlPath = "\(ApiConstants.albumsPath)?userId=\(userId)"
        AF.request(urlPath, method: .get, encoding: JSONEncoding.default)
            .response { response in
                var alboms: [Albom]?
                var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        callback(alboms, err)
                        return
                    }
                    print(JSON(data))
                    do {
                        alboms = try JSONDecoder().decode([Albom].self, from: data)
                    } catch (let decodErr) {
                        print(decodErr)
                    }
                case .failure(let error):
                    err = error
                }
                callback(alboms, err)
            }
    }
    
    static func fetchPhotos(albumId: Int, callback: @escaping (_ result: [Photos]?, _ error: Error?) -> ()) {
        let urlPath = "\(ApiConstants.photosPath)?albumId=\(albumId)"
        AF.request(urlPath, method: .get, encoding: JSONEncoding.default)
            .response { response in
                var photos: [Photos]?
                var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        callback(photos, err)
                        return
                    }
                    print(JSON(data))
                    do {
                        photos = try JSONDecoder().decode([Photos].self, from: data)
                    } catch (let decodErr) {
                        print(decodErr)
                    }
                case .failure(let error):
                    err = error
                }
                callback(photos, err)
            }
    }
    
    static func deletePhotos(albumId: Int, callback: @escaping (_ result: [Photos]?, _ error: Error?) -> ()) {
        let urlPath = "\(ApiConstants.photosPath)?albumId=\(albumId)"
            AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
            .response { response in
            var photos: [Photos]?
            var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        callback(photos, err)
                        return
                    }
                    print(JSON(data))
                case .failure(let error):
                    err = error
                }
                callback(photos, err)
        }
    }
    
    static func getThumbnail(thumbnailURL: String, callback: @escaping (_ result: UIImage?, _ error: Error?) -> ()) {
        if let image = CacheManager.shared.imageCache.image(withIdentifier: thumbnailURL) {
            callback(image, nil)
        } else {
            AF.request(thumbnailURL).responseImage { response in
                switch response.result {
                case .success(let image):
                    CacheManager.shared.imageCache.add(image, withIdentifier: thumbnailURL)
                    callback(image, nil)
                case .failure(let error):
                    callback(nil, error)
                }
            }
        }
    }
    
    static func getData(url: URL, complition: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: complition).resume()
    }
    
    static func downloadImage(url: URL, callback: @escaping (_ result: UIImage?, _ error: Error?) -> ()) {
        getData(url: url) { data, _, error in
            if let data,
               let image = UIImage(data: data) {
                callback(image, nil)
            } else {
                callback(nil, error)
            }
        }
    }
}

