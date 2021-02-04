//
//  HomeViewModel.swift
//  JsonFetcher
//
//  Created by Денис on 03.02.2021.
//

import UIKit

protocol HomeViewModelProtocol {
    init(networkingManager: Networking, router: RouterProtocol)
    var sections: [Section]? { get }
    func fetchDataResponse(completion: @escaping () -> ())
    func numberOfRow() -> Int?
    func tapOnSection(section: Section?)
    func getCellFor(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell?
}

final class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Properties
    var sections: [Section]?
    var router: RouterProtocol!
    var networkingManager: Networking!
    
    required init(networkingManager: Networking, router: RouterProtocol) {
        self.router = router
        self.networkingManager = networkingManager
    }
    
    // MARK: - Methods
    func fetchDataResponse(completion: @escaping () -> ()) {
        networkingManager.fetchData(from: API.baseURL) { [weak self] response in
            guard let response = response else { return }
            guard let self = self else { return }
            self.sections = self.getSectionsFromResponse(response: response)
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func numberOfRow() -> Int? {
        return sections?.count
    }
    
    func tapOnSection(section: Section?) {
        router.showDetails(section: section)
    }
    
    func getCellFor(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell? {
        switch sections?[indexPath.row].name {
        case "hz":
            let cell = TextTableViewCell.dequeue(tableView, for: indexPath)
            let cellViewModel = getCellViewModel(at: indexPath)
            cell.viewModel = cellViewModel
            cell.awakeFromNib()
            return cell

        case "picture":
            let cell = PictureTableViewCell.dequeue(tableView, for: indexPath)
            let cellViewModel = getCellViewModel(at: indexPath)
            cell.viewModel = cellViewModel
            cell.awakeFromNib()
            return cell

        case "selector":
            let cell = SelectorTableViewCell.dequeue(tableView, for: indexPath)
            let cellViewModel = getCellViewModel(at: indexPath)
            cell.viewModel = cellViewModel
            cell.awakeFromNib()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    private func getCellViewModel(at indexPath: IndexPath) -> CellViewModelProtocol? {
        let section = sections?[indexPath.row]
        return CellViewModel(section: section)
    }
    
    private func getSectionsFromResponse(response: Response) -> [Section] {
        var sections = [Section]()
        response.view.forEach { view in
            guard let section = response.data.first(where: { $0.name == view}) else { return }
            sections.append(section)
        }
        return sections
    }
}
