//
//  HomeViewController.swift
//  JsonFetcher
//
//  Created by Денис on 03.02.2021.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    var viewModel: HomeViewModelProtocol? {
        didSet {
            viewModel?.fetchDataResponse { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        setupConstraits()
        cellRegister()
    }
    
    // MARK: - Methods
    private func cellRegister() {
        TextTableViewCell.register(tableView)
        PictureTableViewCell.register(tableView)
        SelectorTableViewCell.register(tableView)
    }
    
    private func setupConstraits() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRow() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = viewModel?.getCellFor(tableView, at: indexPath) else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = viewModel?.sections?[indexPath.row]
        viewModel?.tapOnSection(section: section)
    }
}
