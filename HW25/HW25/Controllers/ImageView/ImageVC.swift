//
//  ImageVC.swift
//  HW25
//
//  Created by Вадим Игнатенко on 12.10.23.
//

import UIKit

class ImageVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    private let inamgeURL = "https://images.pexels.com/photos/220769/pexels-photo-220769.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }

    private func fetchImage() {
        guard let url = URL(string: inamgeURL) else { return }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async {
                guard let self else { return }
                self.activityIndicatorView.stopAnimating()
                if let data = data,
                   let image = UIImage(data: data)
                {
                    self.imageView.image = image
                }
            }
        }.resume()
    }
}
