//
//  PhotoVC.swift
//  HW25
//
//  Created by Вадим Игнатенко on 23.10.23.
//

import UIKit

class PhotoVC: UIViewController {

    var photo: Photos?
    
    private lazy var activityIdn: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView ()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.style = .large
        activityIndicatorView.color = .black
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "imageDefault")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.addSubview(activityIdn)
        getPhoto()
        setupNSLayoutConstraints()
    }
    
    private func getPhoto() {
        guard let photo,
              let imagePath = photo.url,
              let url = URL(string: imagePath) else
        { return }
        NetworkService.downloadImage(url: url) { [weak self] result, error in
            if let error {
                print(error)
            } else if
                let image = result,
                let self {
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.activityIdn.stopAnimating()
                }
            }
        }
    }
    
    private func setupNSLayoutConstraints() {
        NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: activityIdn, attribute: .centerX, relatedBy: .equal, toItem: imageView, attribute: .centerXWithinMargins, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: activityIdn, attribute: .centerY, relatedBy: .equal, toItem: imageView, attribute: .centerYWithinMargins, multiplier: 1, constant: 0).isActive = true
    }

}
