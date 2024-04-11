//
//  FuturedCell.swift
//  Haus
//
//  Created by Ilahe Samedova on 17.03.24.
//

import UIKit
import SnapKit

class FuturedCell: UICollectionViewCell{
    static var identifier: String = "FuturedCell"
    var images = ["reel1", "reel2", "reel3", "reel1"]
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "Önə çıxan postlar"
        return label
    }()
    
    var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .grayColor2
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ReelsCell.self, forCellWithReuseIdentifier: ReelsCell.identifier)
        
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(lineView)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(18)
            make.bottom.equalTo(collectionView.snp.top).offset(-16)
            
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(lineView.snp.bottom).offset(-24)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FuturedCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReelsCell.identifier, for: indexPath) as! ReelsCell
        //cell.layer.cornerRadius = 10
        cell.configure(with: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: collectionView.bounds.height)
    }
}
