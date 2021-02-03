//
//  TextTableViewCell.swift
//  JsonFetcher
//
//  Created by Денис on 03.02.2021.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellId = "TextTableViewCell"
    
    var viewModel: CellViewModelProtocol!

    private lazy var myTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupConstraits()
        updateCell()
    }
    
    // MARK: - Methods
    private func updateCell() {
        myTextLabel.text = viewModel.text
    }

    private func setupConstraits() {
        addSubview(myTextLabel)
        myTextLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        myTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    }
    
    static func register(_ tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: cellId)
    }
    
    static func dequeue(_ tableView: UITableView, for indexPath: IndexPath) -> TextTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TextTableViewCell else { return TextTableViewCell() }
        return cell
    }
}
