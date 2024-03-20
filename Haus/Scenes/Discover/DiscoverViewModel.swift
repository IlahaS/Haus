//
//  DiscoverViewModel.swift
//  Hous
//
//  Created by Ilahe Samedova on 20.02.24.
//

import Foundation
import UIKit
class DiscoverViewModel {
    
    var items = [Item]()
    var discover: Discover?
    var manager = NetworkManager()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    let url = Endpoints.discover.rawValue
    
    func fetchVideos() {
        manager.request(type: Discover.self, endpoint: url) { [weak self] data, errorMessage in
            guard let self = self else { return }
            
            if errorMessage != nil {
                self.error?(errorMessage ?? "")
            } else if let data = data {
                self.items = data.first?.data?.items ?? []
                self.success?()
            }
        }
    }
    
}
