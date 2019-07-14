//
//  CategoriesTableViewController.swift
//  Bootcamp-iOS.FIAP
//
//  Created by Leandro Romano on 13/07/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    let categories = ["animal", "dev", "food", "money"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    fileprivate func setupView() {
        title = "Categories"
    }
    
    fileprivate func setupTableView() {
        tableView.register(
            UINib(nibName: String(describing: CategoryTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: CategoryTableViewCell.identifier
        )
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoryTableViewCell.identifier,
            for: indexPath) as? CategoryTableViewCell
        else { return UITableViewCell() }
        cell.categoryNameLabel.text = categories[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
