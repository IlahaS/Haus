//
//  ProfileHeaderView+Followings.swift
//  Hous
//
//  Created by Ilahe Samedova on 17.02.24.
//

import UIKit

class FollowingsView: UIView{
    
    //let headerView = HeaderView()
    
    //    private let followingView: UIView = {
    //        let view = UIView()
    //        view.backgroundColor = .white
    //        return view
    //    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 35
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Real Əmlak"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Real əmlak şirkəti 1998-ci ildən fəaliyyət göstərir. Fəaliyyət ərazisi Bakı, Sumqayıt və Xırdalan şəhərlərini əhatə edir."
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let followersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    let followingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    let postsCountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    let announcementStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFollowingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupFollowingView() {
        
        //addSubview(headerView)
        //addSubview(followingView)
        
        snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
        }
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(72)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        addSubview(followingStackView)
        followingStackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        addSubview(followersStackView)
        followersStackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.trailing.equalTo(followingStackView.snp.leading).offset(-30)
        }
        
        addSubview(postsCountStackView)
        postsCountStackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.trailing.equalTo(followersStackView.snp.leading).offset(-30)
        }
        
        addSubview(announcementStackView)
        announcementStackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.trailing.equalTo(postsCountStackView.snp.leading).offset(-30)
        }
        
        setupStackView(stackView: announcementStackView, title: "Elan", value: "10")
        setupStackView(stackView: postsCountStackView, title: "Post", value: "100")
        setupStackView(stackView: followersStackView, title: "İzləyici", value: "24")
        setupStackView(stackView: followingStackView, title: "İzlənilən", value: "62")
    }
    
    private func setupStackView(stackView: UIStackView, title: String, value: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = .grayColor
        titleLabel.textAlignment = .center
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.boldSystemFont(ofSize: 16)
        valueLabel.textAlignment = .center
        
        stackView.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(titleLabel)
    }
}
