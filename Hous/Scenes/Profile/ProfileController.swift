import UIKit
import SnapKit

class ProfileController: UIViewController {
    
    private var isDiscoverButtonSelected = false
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 165, height: 201)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupCollectionView()
    
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "postCollectionCell")
        collectionView.register(ProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "profileHeader")
        collectionView.register(ReelsCell.self, forCellWithReuseIdentifier: ReelsCell.identifier)

        //postDiscoverView.delegate = collectionView.headerView
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if let profileHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "profileHeader", for: IndexPath(item: 0, section: 0)) as? ProfileHeaderView {
                    profileHeaderView.delegate = self
                }

//                postDiscoverView.didSelectDiscoverButton = { [weak self] in
//                    self?.isDiscoverButtonSelected = true
//                    self?.collectionView.reloadData()
//                }
//
//                postDiscoverView.didSelectHomeButton = { [weak self] in
//                    self?.isDiscoverButtonSelected = false
//                    self?.collectionView.reloadData()
//                }
    }
}

extension ProfileController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isDiscoverButtonSelected {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReelsCell", for: indexPath) as! ReelsCell
            cell.backgroundColor = .gray
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCollectionCell", for: indexPath) as! PostCell
            cell.priceLabel.text = "Post Title \(indexPath.item + 1)"
            cell.descriptionLabel.text = "Lorem ipsum dolor sit amet"
            cell.locationLabel.text = "28 May metro"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isDiscoverButtonSelected {
            return CGSize(width: (collectionView.frame.width - 2 ) / 3, height: 130)
        } else {
            return CGSize(width: (collectionView.frame.width - 40) / 2, height: 201)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if isDiscoverButtonSelected {
            .init(top: 0, left: 0, bottom: 0, right: 0)
        }else{
            .init(top: 0, left: 13, bottom: 0, right: 13)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "profileHeader", for: indexPath) as! ProfileHeaderView
        headerView.delegate = self
        return headerView
    }

}
extension ProfileController: ProfileHeaderViewDelegate {
    func didSelectDiscoverButton() {
        isDiscoverButtonSelected = true
        collectionView.reloadData()
        //postDiscoverView.didSelectDiscoverButton?()

        
    }
    
    func didSelectHomeButton() {
        isDiscoverButtonSelected = false
                collectionView.reloadData()
        //postDiscoverView.didSelectHomeButton?()

    }
}
