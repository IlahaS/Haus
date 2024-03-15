//
//  SearchPropertyCell.swift
//  Haus
//
//  Created by Ilahe Samedova on 28.02.24.
//

import UIKit
import SnapKit

class SearchPropertyCell: UICollectionViewCell {
    static let identifier = "SearchPropertyCell"
    
    let searchView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.cornerRadius = 10
        view.backgroundColor = .grayColor2
        return view
    }()
    
    let searchText: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.placeholder = "Əmlak axtar"
        
        return textField
    }()
    
    let filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(searchView)
        addSubview(searchText)
        addSubview(filterButton)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        searchView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(70)
        }
        
        searchText.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalTo(searchView).inset(16)
            make.trailing.equalTo(filterButton.snp.leading).offset(-8)
        }
        
        filterButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview().inset(16)
            make.width.equalTo(40)
        }
    }
}
