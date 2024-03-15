//
//  AccountTypeCell.swift
//  Haus
//
//  Created by Ilahe Samedova on 29.02.24.
//

import UIKit

class AccountTypeCell: UICollectionViewCell {
    static let identifier = "AccountTypeCell"
    
    private let symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .grayColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.addSubview(symbolImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        symbolImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(28)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(symbolImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configure(for accountType: AccountType, isSelected: Bool) {
        
        switch accountType {
        case .personal:
            symbolImageView.image = UIImage(systemName: "person.fill")
            titleLabel.text = "Fərdi"
            descriptionLabel.text = "Vasitəçi fəaliyyəti göstərməyən şəxslər üçün hesab."
        case .agent:
            symbolImageView.image = UIImage(systemName: "house.fill")
            titleLabel.text = "Agent"
            descriptionLabel.text = "Evlərin alqı-satqısı ilə məşğul olan şəxs və şirkətlər üçün hesab."
        }
        
        contentView.backgroundColor = isSelected ? .mainBlueColor : .clear
        symbolImageView.tintColor = isSelected ? .white : .black
        titleLabel.textColor = isSelected ? .white : .black
        descriptionLabel.textColor = isSelected ? .white : .grayColor
        contentView.layer.cornerRadius = 10
    }
    
}
