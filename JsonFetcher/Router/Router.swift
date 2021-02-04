//
//  Router.swift
//  JsonFetcher
//
//  Created by Денис on 03.02.2021.
//

import UIKit

protocol Routable {
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
}

protocol RouterProtocol: Routable {
    func initialViewController()
    func showDetails(section: Section?)
}

final class Router: RouterProtocol {
    
    // MARK: - Properties
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    
    init(navigationController: UINavigationController?, builder: BuilderProtocol?) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    // MARK: - Methods
    func initialViewController() {
        if let navigationController = navigationController {
            guard let homeVC = builder?.createHomeModule(router: self) else { return }
            navigationController.viewControllers = [homeVC]
        }
    }
    
    func showDetails(section: Section?) {
        if let navigationController = navigationController {
            guard let detailsVC = builder?.createDetailsModule(section: section) else { return }
            navigationController.pushViewController(detailsVC, animated: true)
        }
    }
}


