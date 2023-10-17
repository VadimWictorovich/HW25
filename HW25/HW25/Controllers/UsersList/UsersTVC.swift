//
//  UsersTVC.swift
//  HW25
//
//  Created by Вадим Игнатенко on 12.10.23.
//

import UIKit

class UsersTVC: UITableViewController {
    
    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name?.description
        cell.detailTextLabel?.text = user.email?.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else { return }
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }

    private func fetchUsers() {
        guard let usersURL = ApiConstants.usersURL else { return }
        URLSession.shared.dataTask(with: URLRequest(url: usersURL)) { [weak self] data, response, error in
            guard let self else { return }
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                do {
                    self.users = try JSONDecoder().decode([User].self, from: data)
                } catch  {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
      
    }
}
