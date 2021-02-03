//
//  DetailsViewModel.swift
//  JsonFetcher
//
//  Created by Денис on 03.02.2021.
//

import Foundation


protocol DetailsViewModelProtocol {
    init(section: Section?)
    var sectionName: String { get }
}

final class DetailsViewModel: DetailsViewModelProtocol {
    
    var section: Section?
    
    var sectionName: String {
        return section?.name ?? ""
    }
    
    required init(section: Section?) {
        self.section = section
    }
}
