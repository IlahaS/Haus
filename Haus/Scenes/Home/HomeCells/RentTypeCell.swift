//
//  RentTypeCell.swift
//  Haus
//
//  Created by Ilahe Samedova on 27.02.24.
//

import Foundation
import UIKit

class RentTypeCell: UICollectionViewCell, ConfigurableCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    static var identifier: String = "RentTypeCell"
    
    let titles = ["Həyət evi/\nBağ evi al", "Yeni tikilidə\nmənzil al", "Bakıda mənzil\nkirayələ", "Torpaq\nsahəsi al"]
    let images = ["type1", "type2", "type3", "type4"]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        //collection.backgroundColor = .black
        collection.showsHorizontalScrollIndicator = false
        collection.register(TypeCell.self, forCellWithReuseIdentifier: TypeCell.identifier)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        setupUI()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCell.identifier, for: indexPath) as! TypeCell
        cell.layer.cornerRadius = 10
        cell.titleLabel.text = titles[indexPath.row]
        cell.imageView.image = UIImage(named: images[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        return CGSize(width: width, height: 110)
        return CGSize(width: 105, height: 110)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    func configure() {
        
    }
}

class TypeCell: UICollectionViewCell{
    static let identifier = "TypeCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
        
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(110)
            make.width.equalTo(105)
            //make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.trailing.top.equalToSuperview().inset(10)
            make.bottom.lessThanOrEqualToSuperview().inset(10)
        }
    }
}

