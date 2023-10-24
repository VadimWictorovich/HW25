//
//  PhotosCollectionVC.swift
//  HW25
//
//  Created by Вадим Игнатенко on 23.10.23.
//

import UIKit


final class PhotosCollectionVC: UICollectionViewController {
    
    var albom: Albom?
    var photos: [Photos] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "PhotosCVCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        fetchPhoto()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let layout = UICollectionViewFlowLayout()
        let sizeWH = UIScreen.main.bounds.width / 3 - 10
        layout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        collectionView.collectionViewLayout = layout
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = photos[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotosCVCell
        cell.thumbnailUrl = photo.thumbnailUrl
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ -> UIMenu in
            let deleteAction = UIAction(title: "Удалить", image: nil) { action in
                guard let self else { return }
                let photoId = self.photos[indexPath.row].id
                NetworkService.deletePhotos(photoId: photoId) { _, _ in
                    self.photos.remove(at: indexPath.row)
                    self.collectionView.deleteItems(at: [indexPath])
                    }
                }
            let menu = UIMenu(title: "", children: [deleteAction])
            return menu
        }
        return configuration
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        let vc = PhotoVC()
        vc.photo = photo
        self.present(vc, animated: true)
    }
    
    private func fetchPhoto() {
        guard let albom else { return }
        NetworkService.fetchPhotos(albumId: albom.id) { [weak self] result, error in
            if let error = error {
                print(error)
            } else if let photos = result {
                self?.photos = photos
                self?.collectionView.reloadData()
            }
        }
    }
}
