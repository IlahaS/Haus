import UIKit
import SwiftUI
import SnapKit

class ProfileController: UIViewController {
    
    private var isDiscoverButtonSelected = false
    
    var prices = ["26 000 AZN", "423 000 AZN", "55 000 AZN", "264 000 AZN", "2 444 000 AZN", "90 000 AZN"]
    var images = ["post1", "post2", "post3", "post4", "post1", "post2"]
    var reels = ["reel1", "reel3", "reel2", "reel3", "reel2", "reel1","reel1", "reel2", "reel3", "reel3", "reel2"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 165, height: 201)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupCollectionView()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupUI() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let statusBarManager = windowScene.statusBarManager {
            let statusBarView = UIView(frame: statusBarManager.statusBarFrame)
            statusBarView.backgroundColor = .white
            view.addSubview(statusBarView)
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "postCollectionCell")
        collectionView.register(ReelsCell.self, forCellWithReuseIdentifier: ReelsCell.identifier)
        collectionView.register(ProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(ProfileHeaderView.self)")
    }
}

extension ProfileController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isDiscoverButtonSelected {
            return reels.count
        }
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isDiscoverButtonSelected {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReelsCell", for: indexPath) as! ReelsCell
            cell.imageView.image = UIImage(named: reels[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCollectionCell", for: indexPath) as! PostCell
            cell.priceLabel.text = prices[indexPath.row]
            cell.postImageView.image = UIImage(named: images[indexPath.row])
            cell.descriptionLabel.text = "3 otaqlı · 96 m2 · 4/17 mərtəbə"
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
        return CGSize(width: collectionView.frame.width, height: 274)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if isDiscoverButtonSelected {
            return .init(top: 0, left: 0, bottom: 0, right: 0)
        }
        return .init(top: 0, left: 13, bottom: 0, right: 13)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(ProfileHeaderView.self)", for: indexPath) as! ProfileHeaderView
        headerView.delegate = self
        return headerView
    }
}
extension ProfileController: ProfileHeaderViewDelegate{
    
    func didSelectSetting() {
        
        let vc = SettingsController()
        navigationController?.pushViewController(vc, animated: true)
        
        print(navigationController?.viewControllers.count ?? 0)
        print(navigationController?.viewControllers ?? ProfileController())
    }
    
    func didSelectDiscoverButton() {
        isDiscoverButtonSelected = true
        collectionView.reloadData()
    }
    
    func didSelectHomeButton() {
        isDiscoverButtonSelected = false
        collectionView.reloadData()
    }
    
    func didSelectPlusButton() {
        let initialListView = InitialListScreen()
        let hostingController = UIHostingController(rootView: initialListView)
        navigationController?.pushViewController(hostingController, animated: true)
        
    }
    
}
