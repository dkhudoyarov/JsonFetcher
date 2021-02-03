//
//  PictureTableViewCell.swift
//  JsonFetcher
//
//  Created by Денис on 03.02.2021.
//

import UIKit

class PictureTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellId = "PictureTableViewCell"
    
    var viewModel: CellViewModelProtocol!
    
    var pictureImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupContraits()
        updateCell()
    }
    
    // MARK: - Methods
    private func updateCell() {
        pictureImageView.set(imageURL: viewModel.url)
    }

    private func setupContraits() {
        addSubview(pictureImageView)
        pictureImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        pictureImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        pictureImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        pictureImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    static func register(_ tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: cellId)
    }
    
    static func dequeue(_ tableView: UITableView, for indexPath: IndexPath) -> PictureTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PictureTableViewCell else { return PictureTableViewCell() }
        return cell
    }
    
}
