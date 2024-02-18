//
//  PostDiscoverView.swift
//  Hous
//
//  Created by Ilahe Samedova on 17.02.24.
//

import UIKit

class PostDiscoverView: UIView{
    
    var isDiscoverButtonClicked = true
    
    var didSelectHomeButton: (() -> Void)?
        var didSelectDiscoverButton: (() -> Void)?
    
    let segmentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()
    
    let homeLine: UIView = {
        let line = UIView()
        line.backgroundColor = .black
        return line
    }()
    
    let discoverLine: UIView = {
        let line = UIView()
        line.backgroundColor = .gray
        return line
    }()
    
    lazy var homeButton: UIButton = {
        let button = UIButton()
        let spacing: CGFloat = 6.0
        
        button.setTitle("Elanlar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        
        button.setImage(UIImage(named: "HomeBlack")?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)), for: .normal)
        
        //        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
        
        button.addTarget( self, action: #selector(homeButtonTapped), for: .touchUpInside)
        
        
        return button
    }()
    
    lazy var discoverButton: UIButton = {
        let button = UIButton()
        button.setTitle("Postlar", for: .normal)
        button.setTitleColor(.grayColor3, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        let spacing: CGFloat = 6.0
        
        button.setImage(UIImage(named: "DiscoverGray")?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)), for: .normal)
        
        //button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
        
        button.addTarget( self, action: #selector(discoverButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPostDiscoverView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPostDiscoverView() {
        
        homeButton.setImage(UIImage(named: "HomeBlack"), for: .normal)
        discoverButton.setImage(UIImage(named: "DiscoverGray"), for: .normal)
        
        addSubview(segmentStackView)
        segmentStackView.addArrangedSubview(homeButton)
        segmentStackView.addArrangedSubview(discoverButton)
        
        addSubview(homeLine)
        addSubview(discoverLine)
        
        homeLine.snp.makeConstraints { make in
            make.top.equalTo(homeButton.snp.bottom).offset(6)
            make.leading.trailing.equalTo(homeButton)
            make.height.equalTo(1)
        }
        
        discoverLine.snp.makeConstraints { make in
            make.top.equalTo(discoverButton.snp.bottom).offset(6)
            make.leading.trailing.equalTo(discoverButton)
            make.height.equalTo(1)
        }
        
        segmentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(36)
        }
    }
    
    @objc private func discoverButtonTapped() {
        isDiscoverButtonClicked = true
        discoverButton.setImage(UIImage(named: "DiscoverBlack"), for: .normal)
        homeButton.setImage(UIImage(named: "HomeGray"), for: .normal)
        discoverLine.backgroundColor = .black
        homeLine.backgroundColor = .grayColor3
        discoverButton.setTitleColor(.black, for: .normal)
        homeButton.setTitleColor(.grayColor3, for: .normal)
        didSelectDiscoverButton?()
    }
    
    @objc private func homeButtonTapped() {
        isDiscoverButtonClicked = false
        discoverButton.setImage(UIImage(named: "DiscoverGray"), for: .normal)
        homeButton.setImage(UIImage(named: "HomeBlack"), for: .normal)
        discoverLine.backgroundColor = .grayColor3
        homeLine.backgroundColor = .black
        homeButton.setTitleColor(.black, for: .normal)
        discoverButton.setTitleColor(.grayColor3, for: .normal)
        didSelectHomeButton?()
    }
}
