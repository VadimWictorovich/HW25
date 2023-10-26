//
//  CommentsTVC.swift
//  HW25
//
//  Created by Вадим Игнатенко on 23.10.23.
//

import UIKit

final class CommentsTVC: UITableViewController {

    var postId: Int?
    var comments: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchComment()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let comment = comments[indexPath.row]
        cell.textLabel?.text = comment.name
        cell.detailTextLabel?.text = comment.email
        return cell
    }
    
    private func fetchComment() {
        guard let postId else { return }
        NetworkService.fetchComments(postId: postId) { [weak self] result, error in
            if let error = error {
                print(error)
            } else if let comments = result {
                self?.comments = comments
                self?.tableView.reloadData()
            }
        }
    }
}
