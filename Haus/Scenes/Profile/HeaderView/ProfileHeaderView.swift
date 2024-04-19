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
    func didSelectSetting()
    func didSelectPlusButton()
}

class ProfileHeaderView: UICollectionReusableView {

    let identifier = "profileHeader"
    weak var delegate: ProfileHeaderViewDelegate?

    // MARK: UIViews
    let headerView = TitleView()
    let followingsView = FollowingsView()
    let postDiscoverView = PostDiscoverView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    func setupUI() {
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

        addSubview(postDiscoverView)
        postDiscoverView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(followingsView.snp.bottom).offset(17)
            make.height.equalTo(36)
        }

        postDiscoverView.didSelectHomeButton = { [weak self] in
            self?.homeButtonTapped()
        }

        postDiscoverView.didSelectDiscoverButton = { [weak self] in
            self?.discoverButtonTapped()
        }
        
        headerView.settingsButtonTapped = { [weak self] in
            self?.didSelectSettings()
        }
        
        headerView.plussButtonTapped = { [weak self] in
            self?.didSelectPlusButton()
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
    
    @objc private func didSelectSettings() {
        delegate?.didSelectSetting()
    }
    
    @objc private func didSelectPlusButton(){
        delegate?.didSelectPlusButton()
        print("plus button tapped")

    }
}
