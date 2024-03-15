//
//  DiscoverModel.swift
//  Haus
//
//  Created by Ilahe Samedova on 15.03.24.
//

import Foundation

struct DiscoverModel: Codable {
    let createdAt, name: String?
    let avatar: String?
    let description: String?
    let isSuccessful: Bool?
    let statusCode: Int?
    let messages: [String]?
    let data: DataClass?
    let id: String?
}

// MARK: - DataClass
struct DataClass: Codable {
    let indexFrom, pageIndex, pageSize, totalCount: Int?
    let totalPages: Int?
    let items: [Item]?
    let hasPreviousPage, hasNextPage: Bool?
}

// MARK: - Item
struct Item: Codable {
    let id, createdAt, description: String?
    let user: User?
}


typealias Discover = [DiscoverModel]

