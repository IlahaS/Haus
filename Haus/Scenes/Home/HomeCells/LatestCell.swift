//
//  LatestCell.swift
//  Haus
//
//  Created by Ilahe Samedova on 17.03.24.
//

import UIKit

class LatestCell: UICollectionViewCell{
    
    static var identifier: String = "LatestCell"
    
    var latestPost: LatestPost? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var property = [LatestPost]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var images = ["post1", "post2", "post3", "post4"]
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "Ən son elanlar"
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 32) / 2, height: 201)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Daha çox", for: .normal)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .mainBlueColor
        button.imageView?.contentMode = .scaleToFill
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.semanticContentAttribute = .forceRightToLeft
        button.contentHorizontalAlignment = .trailing
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: PostCell.identifier)
        
        addSubview(titleLabel)
        addSubview(moreButton)
        addSubview(collectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalTo(collectionView.snp.top).offset(-16)
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(titleLabel)
            make.height.equalTo(16)
            
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
}

extension LatestCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return property.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.identifier, for: indexPath) as! PostCell
        let post = property[indexPath.item]
        cell.postImageView.image = UIImage(named: images[indexPath.item])
        cell.descriptionLabel.text = "3 otaqlı · 96 m2 · 4/17 mərtəbə"
        cell.configure(with: post)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 12) / 2, height: 201)
    }
}


