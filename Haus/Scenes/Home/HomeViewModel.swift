//
//  HomeViewModel.swift
//  Haus
//
//  Created by Ilahe Samedova on 28.02.24.
//

import Foundation

enum HomeCellItem: Hashable {
    case propertyType ([PropertyType]?)
    case propertySearch (String?)
    case propertyCategory ([PropertyCategory]?)
    case featuredPost ([FeaturedPost]?)
    case propertyList ([PropertyList]?)
    case latestAnnouncements ([LatestAnnouncements]?)
}

struct PropertyType: Hashable{
    
}

struct PropertyCategory: Hashable{
    
}

struct FeaturedPost: Hashable{
    
}

struct PropertyList: Hashable{
    
}

struct LatestAnnouncements: Hashable{
    
}



