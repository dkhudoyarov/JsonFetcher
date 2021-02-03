//
//  CellViewModel.swift
//  JsonFetcher
//
//  Created by Денис on 03.02.2021.
//

import Foundation

protocol CellViewModelProtocol {
    var text: String? { get }
    var url: String? { get }
    var selectedID: Int? { get }
    var variants: [Variant]? { get }
    var titles: [String]? { get }
    init(section: Section?)
}

final class CellViewModel: CellViewModelProtocol {
    var text: String? {
         return section?.data.text
    }
    
    var url: String? {
        return section?.data.url
    }
    
    var selectedID: Int? {
        return section?.data.variants?
            .firstIndex(where: { $0.id == section?.data.selectedID })
    }
    
    var variants: [Variant]? {
        return section?.data.variants
    }
    
    var titles: [String]? {
        return section?.data.variants?.compactMap { $0.text }
    }
    
    var section: Section?
    
    required init(section: Section?) {
        self.section = section
    }
}
