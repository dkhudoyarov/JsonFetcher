//
//  SelectorTableViewCell.swift
//  JsonFetcher
//
//  Created by Денис on 03.02.2021.
//

import UIKit

class SelectorTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellId = "SelectorTableViewCell"
    
    var viewModel: CellViewModelProtocol!
    private var selector: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateCell()
        setupConstraits()
    }
    
    // MARK: - Methods
    private func updateCell() {
        selector = UISegmentedControl(items: viewModel.titles)
        selector.selectedSegmentIndex = viewModel.selectedID ?? 0
        addSubview(selector)
    }

    private func setupConstraits() {
        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.topAnchor.constraint(equalTo: topAnchor).isActive = true
        selector.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        selector.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        selector.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    static func register(_ tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: cellId)
    }
    
    static func dequeue(_ tableView: UITableView, for indexPath: IndexPath) -> SelectorTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SelectorTableViewCell else { return SelectorTableViewCell() }
        return cell
    }
}
