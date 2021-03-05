//
//  File.swift
//  Lister
//
//  Created by Raj on 05/03/2021.
//

import Foundation

// MARK: - PostElement
struct PostElement: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias Post = [PostElement]
