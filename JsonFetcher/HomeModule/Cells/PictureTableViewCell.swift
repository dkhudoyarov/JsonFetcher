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
    
    private lazy var pictureImageView: WebImageView = {
        let image = WebImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupConstraits()
        updateCell()
    }
    
    // MARK: - Methods
    private func updateCell() {
        pictureImageView.set(imageURL: viewModel.url)
    }

    private func setupConstraits() {
        addSubview(pictureImageView)
        pictureImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        pictureImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        pictureImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pictureImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        pictureImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
    }
    
    static func register(_ tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: cellId)
    }
    
    static func dequeue(_ tableView: UITableView, for indexPath: IndexPath) -> PictureTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PictureTableViewCell else { return PictureTableViewCell() }
        return cell
    }
}
