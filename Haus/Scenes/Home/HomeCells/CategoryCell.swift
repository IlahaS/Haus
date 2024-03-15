//
//  CategoryCell.swift
//  Haus
//
//  Created by Ilahe Samedova on 06.03.24.
//
import Foundation
import UIKit

class CategoryCell: UICollectionViewCell, ConfigurableCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    static var identifier: String = "CategoryCell"
    
    let titles = ["Alış", "Kirayə", "Gündəlik Kirayə"]
    let images = ["key", "rent", "daily"]
    
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
        collection.register(CategorySubCell.self, forCellWithReuseIdentifier: CategorySubCell.identifier)
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
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorySubCell.identifier, for: indexPath) as! CategorySubCell
        cell.layer.cornerRadius = 10
        cell.titleLabel.text = titles[indexPath.row]
        cell.imageView.image = UIImage(named: images[indexPath.row])
        cell.backgroundColor = .grayColor2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115, height: 90)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
             .init(top: 10, left: 16, bottom: 10, right: 16)
     }
    
    func configure() {
        
    }
}

class CategorySubCell: UICollectionViewCell{
    static let identifier = "CategorySubCell"
    
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
        label.textColor = .black
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
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(12)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.leading.trailing.top.equalToSuperview().inset(12)
            make.top.equalToSuperview().offset(8)
        }
    }
}

