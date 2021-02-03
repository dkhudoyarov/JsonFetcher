//
//  Builder.swift
//  JsonFetcher
//
//  Created by Денис on 03.02.2021.
//

import UIKit

protocol BuilderProtocol {
    func createHomeModule(router: RouterProtocol) -> UIViewController
    func createDetailsModule(section: Section?) -> UIViewController
}

final class ModuleBuilder: BuilderProtocol {

    func createHomeModule(router: RouterProtocol) -> UIViewController {
        let view = HomeViewController()
        let networkingManager: Networking = NetworkingManager()
        let viewModel = HomeViewModel(networkingManager: networkingManager, router: router)
        view.viewModel = viewModel
        return view
    }
    
    func createDetailsModule(section: Section?) -> UIViewController {
        let view = DetailsViewController()
        let viewModel = DetailsViewModel(section: section)
        view.viewModel = viewModel
        return view
    }
}
