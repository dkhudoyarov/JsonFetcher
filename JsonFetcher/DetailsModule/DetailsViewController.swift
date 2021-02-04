//
//  DetailsViewController.swift
//  JsonFetcher
//
//  Created by Денис on 03.02.2021.
//

import UIKit

class DetailsViewController: UIViewController {
      
    // MARK: - Properties
    var viewModel: DetailsViewModelProtocol!
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateLabel()
        setupConstraits()
    }
    
    // MARK: - Methods
    private func updateLabel() {
        nameLabel.text = viewModel.sectionName
    }
    
    private func setupConstraits() {
        view.addSubview(nameLabel)
        nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
