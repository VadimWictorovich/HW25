//
//  PostsTVC.swift
//  HW25
//
//  Created by Вадим Игнатенко on 17.10.23.
//

import UIKit

class PostsTVC: UITableViewController {

    var user: User?
    var post: [Post] = []
    
    override func viewWillAppear(_ animated: Bool) {
        fetchPosts()
    }
    
    @IBAction func addPostAction(_ sender: Any) {
        let sb = UIStoryboard(name: "PostFlow", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "NewPostVC") as? NewPostVC else { return }
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        post.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let post = post[indexPath.row]
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { true }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let postId = post[indexPath.row].id
            NetworkService.deletePost(postId: postId) { [weak self] _,_ in
                guard let self else { return }
                self.post.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postId = post[indexPath.row].id
        let sb = UIStoryboard(name: "PostFlow", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "CommentsTVC") as? CommentsTVC else { return }
        vc.postId = postId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func fetchPosts() {
        let userId = user?.id.description ?? ""
        let urlPath = "\(ApiConstants.postsPath)?userId=\(userId)"
        guard let url = URL(string: urlPath) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self,
                  let data = data else { return }
            do {
                self.post = try JSONDecoder().decode([Post].self, from: data)
            } catch  {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
}
