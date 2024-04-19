//
//  HomeViewModel.swift
//  Haus
//
//  Created by Ilahe Samedova on 28.02.24.
//

import Foundation

class HomeViewModel {
    enum HomeCellItem {
        case propertyType([String]?)
        case propertySearch(String?)
        case propertyCategory([String]?)
        case featuredPost([FeaturingPost]?)
        case propertyList([LatestPost]?)
        case latestAnnouncements([LatestPost]?)
    }
    
    var propertyTypes: [String]?
    var propertyCategories: [String]?
    var featuredPosts: [FeaturingPost]?
    var propertyList: [LatestPost]?
    var latestAnnouncements: [LatestPost]?
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func fetchData() {
        NetworkManager.shared.request(type: Home.self, endpoint: "home") { [weak self] (homeModel, errorMessage) in
            guard let self = self else { return }
            
            if let errorMessage = errorMessage {
                self.error?(errorMessage)
                return
            }
            
            if let homeModel = homeModel {
                //print(homeModel)
                self.processHomeModel(homeModel)
                self.success?()
            } else {
                self.error?("Failed to fetch data")
            }
        }
    }
    
    private func processHomeModel(_ homeModel: Home) {
        if let homeItems = homeModel.first?.data?.items,
           let items = homeItems.first {
            self.propertyTypes = items.propertyTypes
            self.featuredPosts = items.featuringPosts
            self.propertyList = items.properties
            self.latestAnnouncements = items.latestPosts
        }
    }
    
    func numberOfItems() -> Int {
        return 6
    }
    
    func cellType(at index: Int) -> HomeCellItem {
        switch index {
        case 0:
            return .propertyType(propertyCategories)
        case 1:
            return .propertySearch(nil)
        case 2:
            return .propertyCategory(propertyTypes)
        case 3:
            return .featuredPost(featuredPosts)
        case 4:
            return .propertyList(propertyList)
        case 5:
            return .latestAnnouncements(latestAnnouncements)
        default:
            return .propertyType(nil)
        }
    }
}
extension Array where Element == LatestPost {
    func hash(into hasher: inout Hasher) {
        for element in self {
            hasher.combine(element)
        }
    }
}

extension Array where Element == String {
    func hash(into hasher: inout Hasher) {
        for element in self {
            hasher.combine(element)
        }
    }
}

extension HomeViewModel.HomeCellItem: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .propertyType:
            hasher.combine(0)
        case .propertySearch:
            hasher.combine(1)
        case .propertyCategory(let categories):
            hasher.combine(2)
            hasher.combine(categories)
        case .featuredPost:
            hasher.combine(3)
        case .propertyList(let properties):
            hasher.combine(4)
            hasher.combine(properties)
        case .latestAnnouncements(let announcements):
            hasher.combine(5)
            hasher.combine(announcements)
        }
    }

    static func ==(lhs: HomeViewModel.HomeCellItem, rhs: HomeViewModel.HomeCellItem) -> Bool {
        switch (lhs, rhs) {
        case (.propertyType, .propertyType):
            return true
        case (.propertySearch, .propertySearch):
            return true
        case let (.propertyCategory(lhsCategories), .propertyCategory(rhsCategories)):
            return lhsCategories == rhsCategories
        case (.featuredPost, .featuredPost):
            return true
        case let (.propertyList(lhsProperties), .propertyList(rhsProperties)):
            return lhsProperties == rhsProperties
        case let (.latestAnnouncements(lhsAnnouncements), .latestAnnouncements(rhsAnnouncements)):
            return lhsAnnouncements == rhsAnnouncements
        default:
            return false
        }
    }
}

extension LatestPost: Hashable {
    static func == (lhs: LatestPost, rhs: LatestPost) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

