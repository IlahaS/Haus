//
//  ReelsCollectionView.swift
//  Hous
//
//  Created by Ilahe Samedova on 13.02.24.
//

import UIKit
import SnapKit

class ReelsCollectionView: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 165, height: 201)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
            collectionView.delegate = self
            collectionView.dataSource = self

            collectionView.register(ReelsCell.self, forCellWithReuseIdentifier: ReelsCell.identifier)

            view.addSubview(collectionView)

            collectionView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
}

extension ReelsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReelsCell", for: indexPath) as! ReelsCell
        
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 32) / 2, height: 201)
    }
}


