//
//  PhotosCVCell.swift
//  HW25
//
//  Created by Вадим Игнатенко on 23.10.23.
//

import UIKit

class PhotosCVCell: UICollectionViewCell {
   
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    var thumbnailUrl: String? {
        didSet {
            fetchThumbnailUrl()
        }
    }

    private func fetchThumbnailUrl() {
        guard let thumbnailUrl else { return }
        NetworkService.getThumbnail(thumbnailURL: thumbnailUrl) { [weak self] result, error in
            if let error {
                print(error)
            } else if let image = result{
                self?.activityIndicatorView.stopAnimating()
                self?.imageView.image = image
            }
        }
    }
}

    
