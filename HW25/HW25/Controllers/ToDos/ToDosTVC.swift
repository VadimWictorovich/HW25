//
//  ToDosTVC.swift
//  HW25
//
//  Created by Вадим Игнатенко on 23.10.23.
//

import UIKit

class ToDosTVC: UITableViewController {

    var user: User?
    var toDos: [ToDos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchToDos()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let toDos = toDos[indexPath.row]
        cell.textLabel?.text = toDos.title
        cell.detailTextLabel?.text = toDos.completed?.description
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
    
    private func fetchToDos() {
        guard let user else { return }
        NetworkService.fetchToDos(userId: user.id) { [weak self] result, error in
            if let error = error {
                print(error)
            } else if let toDos = result{
                self?.toDos = toDos
                self?.tableView.reloadData()
            }
        }
    }
}
