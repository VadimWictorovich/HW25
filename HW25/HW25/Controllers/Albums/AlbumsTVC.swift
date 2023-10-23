//
//  AlbumsTVC.swift
//  HW25
//
//  Created by Вадим Игнатенко on 17.10.23.
//

import UIKit

class AlbumsTVC: UITableViewController {

    var user: User?
    var albums: [Albom] = []

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let albom = albums[indexPath.row]
        cell.textLabel?.text = albom.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albom = albums[indexPath.row]
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "PhotosCollectionVC") as? PhotosCollectionVC else { return }
        vc.albom = albom
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func fetchAlbom() {
        guard let user else { return }
        NetworkService.fetchAlboms(userId: user.id) { [weak self] result, error in
            if let error = error {
                print(error)
            } else if let alboms = result {
                self?.albums = alboms
                self?.tableView.reloadData()
            }
        }
    }
    

}
