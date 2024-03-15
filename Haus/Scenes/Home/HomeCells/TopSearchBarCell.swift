//
//  TopSearchBarCell.swift
//  Haus
//
//  Created by Ilahe Samedova on 28.02.24.
//

import Foundation
import UIKit

class TopSearchBarCell: UICollectionViewCell {
    
    static var identifier: String = "TopSearchBarCell"
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private let notificationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(searchBar)
        addSubview(notificationButton)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(notificationButton.snp.leading).offset(-16)
        }
        
        notificationButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchBar)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(24)
        }
    }
}
