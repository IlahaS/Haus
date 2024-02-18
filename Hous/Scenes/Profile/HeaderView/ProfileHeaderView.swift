//
//  PostCollectionHeaderView.swift
//  Hous
//
//  Created by Ilahe Samedova on 04.02.24.
//

import Foundation
import UIKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func didSelectHomeButton()
    func didSelectDiscoverButton()
}


class ProfileHeaderView: UICollectionReusableView {
    
    weak var delegate: ProfileHeaderViewDelegate?
    
    // MARK: UIViews
    let headerView = TitleView()
    let followingsView = FollowingsView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI(){
        
        addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        addSubview(followingsView)
        followingsView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(160)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func discoverButtonTapped() {

            delegate?.didSelectDiscoverButton()
        }
        
        @objc private func homeButtonTapped() {
            
            delegate?.didSelectHomeButton()
        }
    
}
