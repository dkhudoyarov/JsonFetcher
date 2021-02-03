//
//  Response.swift
//  JsonFetcher
//
//  Created by Денис on 03.02.2021.
//

import Foundation

struct Response: Codable {
    let data: [Section]
    let view: [String]
}

struct Section: Codable {
    let name: String
    let data: SectionData
}

struct SectionData: Codable {
    let text: String?
    let url: String?
    let selectedID: Int?
    let variants: [Variant]?

    enum CodingKeys: String, CodingKey {
        case text, url
        case selectedID = "selectedId"
        case variants
    }
}

struct Variant: Codable {
    let id: Int
    let text: String
}



