//
//  CategoriesTableViewController.swift
//  Bootcamp-iOS.FIAP
//
//  Created by Leandro Romano on 13/07/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    var categories = [String]()
    
    // MARK: - View Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        requestCategories()
    }
    
    // MARK: - Setup Views
    
    fileprivate func setupView() {
        title = Constants.tableViewTitle
    }
    
    fileprivate func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(
            UINib(nibName: String(describing: CategoryTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: CategoryTableViewCell.identifier
        )
    }
    
    fileprivate func requestCategories() {
        NetworkProvider.shared.request(Constants.categoriesUrl) { [weak self] (result: Result<[String], NetworkError>) in
            if case .success(let categories) = result {
                self?.categories = categories
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table View Delegate and Data Source

    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
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
        performSegue(withIdentifier: Constants.jokeSegueIdentifier, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? JokesViewController,
            let selectedRow = tableView.indexPathForSelectedRow?.row
        else { return }
        
        let category = categories[selectedRow]
        
        destination.category = category
    }
    
}
