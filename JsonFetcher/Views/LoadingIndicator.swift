//
//  LoadingIndicator.swift
//  JsonFetcher
//
//  Created by Денис on 04.02.2021.
//

import UIKit

class LoadingIndicator: UIView {
    
    private lazy var activity: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .medium
        return indicator
    }()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func show(for view: UIView) {
        backView.addSubview(activity)
        view.addSubview(backView)
        
        backView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        activity.topAnchor.constraint(equalTo: backView.topAnchor).isActive = true
        activity.bottomAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        activity.leadingAnchor.constraint(equalTo: backView.leadingAnchor).isActive = true
        activity.trailingAnchor.constraint(equalTo: backView.trailingAnchor).isActive = true
        
        activity.startAnimating()
    }
    
    func hideAfter(deadline: DispatchTime) {
        DispatchQueue.main.asyncAfter(deadline: deadline) { [weak self] in
            guard let self = self else { return }
            self.activity.stopAnimating()
            self.backView.removeFromSuperview()
        }
    }
}
