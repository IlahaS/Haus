//
//  ProfileCell.swift
//  Hous
//
//  Created by Ilahe Samedova on 04.02.24.
//

import UIKit
import SnapKit

protocol PostCellProtocol{
    
    var imagePath: String { get }
    var priceValue: Int { get }
    var descriptionLabel: String { get }
    var locationLabel: String { get }
}

class PostCell: UICollectionViewCell {
    
    static let identifier = "PostCell"
    
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postImageView)
        addSubview(priceLabel)
        addSubview(descriptionLabel)
        addSubview(locationLabel)
        
        postImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(124)
            make.width.equalTo(165.5)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview()
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post: PostCellProtocol){
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let formattedPrice = formatter.string(from: NSNumber(value: post.priceValue)) {
            priceLabel.text = "\(formattedPrice) AZN"
        } else {
            priceLabel.text = "\(post.priceValue) AZN"
        }
        
        locationLabel.text = post.locationLabel
    }
}
