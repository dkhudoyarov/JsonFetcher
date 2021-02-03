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
    func getSectionForRow(at indexPath: IndexPath) -> Section?
    func tapOnSection(section: Section?)
    func cellViewModel(at indexPath: IndexPath) -> CellViewModelProtocol?
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
    
    private func getSectionsFromResponse(response: Response) -> [Section] {
        var sections = [Section]()
        response.view.forEach { view in
            guard let section = response.data.first(where: { $0.name == view}) else { return }
            sections.append(section)
        }
        return sections
    }
    
    func numberOfRow() -> Int? {
        return sections?.count
    }
    
    func getSectionForRow(at indexPath: IndexPath) -> Section? {
        return sections?[indexPath.row]
    }
    
    func tapOnSection(section: Section?) {
        router.showDetails(section: section)
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CellViewModelProtocol? {
        let section = sections?[indexPath.row]
        return CellViewModel(section: section)
    }
}
