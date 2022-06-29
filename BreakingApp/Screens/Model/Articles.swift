//
//  Articles.swift
//  BreakingApp
//
//  Created by Mahmut Taha Cerit on 26.06.2022.
//

import Foundation
struct Articles: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case author, title, description = "description"
        case url
        case urlToImage
        case content = "content"
    }
}
