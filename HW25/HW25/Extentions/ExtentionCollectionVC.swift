//
//  ExtentionCollectionVC.swift
//  HW25
//
//  Created by Вадим Игнатенко on 12.10.23.
//

import UIKit

extension CollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 50, height: 80)
    }
}
