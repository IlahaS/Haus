//
//  HomeModel.swift
//  Haus
//
//  Created by Ilahe Samedova on 20.03.24.
//

import Foundation

// MARK: - WelcomeElement
struct HomeModel: Codable {
    let isSuccessful: Bool?
    let statusCode: Int?
    let messages: [String]?
    let data: DataClass?
}

// MARK: - DataClass
struct DataModel: Codable {
    let indexFrom, pageIndex, pageSize, totalCount: Int?
    let totalPages: Int?
    let items: [HomeItems]?
    let hasPreviousPage, hasNextPage: Bool?
}

// MARK: - Item
struct HomeItems: Codable {
    let propertyTypes: [String]?
    let featuringPosts: [FeaturingPost]?
    let properties, latestPosts: [LatestPost]?
}

// MARK: - FeaturingPost
struct FeaturingPost: Codable {
    let id, videoURL: String?

    enum CodingKeys: String, CodingKey {
        case id
        case videoURL = "videoUrl"
    }
}

// MARK: - LatestPost
struct LatestPost: Codable {
    let id: String?
    let price: Int?
    let photoURL: String?
    let roomCount: Int?
    let floor: String?
    let square: Int?
    let metroStation: String?

    enum CodingKeys: String, CodingKey {
        case id, price
        case photoURL = "photoUrl"
        case roomCount, floor, square, metroStation
    }
}

typealias Home = [HomeModel]