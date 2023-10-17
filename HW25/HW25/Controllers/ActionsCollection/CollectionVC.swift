//
//  CollectionVC.swift
//  HW25
//
//  Created by Вадим Игнатенко on 12.10.23.
//

import UIKit



enum UserActions: String, CaseIterable {
    case downloadImage = "Download image"
    case users = "Open users list"
}



class CollectionVC: UICollectionViewController {
    
    private let reuseIdentifier = "Cell"
    private let userActions = UserActions.allCases

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ActionCVCell
        let userAction = userActions[indexPath.row].rawValue
        cell.infiLbl.text = userAction
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.row]
        let sb = UIStoryboard(name: "Main", bundle: nil)
        switch userAction {
            case .downloadImage:
            guard let vc = sb.instantiateViewController(withIdentifier: "ImageVC") as? ImageVC else { return }
            navigationController?.pushViewController(vc, animated: true)
            case .users:
            guard let vc = sb.instantiateViewController(withIdentifier: "UsersTVC") as? UsersTVC else { return }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
