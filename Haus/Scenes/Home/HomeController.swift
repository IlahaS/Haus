import UIKit
import SnapKit

protocol ConfigurableCell{
    static var identifier: String { get set }
    
    func configure()
}

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    
    let homeCellTypes: [HomeCellItem] = [
        .propertyType([]),
        .propertySearch(""),
        .propertyCategory([]),
        .featuredPost([]),
        .propertyList([]),
        .latestAnnouncements([])
    ]

    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Şəhər, rayon, metro"
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        setupUI()
    }
    
    private func setupUI() {
        setupSearchBar()
        configureCollectionViewLayout()
    }
    
    private func setupSearchBar() {
        let notificationButton = UIButton.init(type: .system)
        notificationButton.setImage(UIImage(systemName: "bell"), for: .normal)
        notificationButton.contentMode = .scaleAspectFit
        notificationButton.tintColor = .black
        view.addSubview(searchBar)
        view.addSubview(notificationButton)
        
        searchBar.searchBarStyle = .minimal
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(notificationButton.snp.leading).offset(-5)
        }
        
        notificationButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchBar)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(36)
        }
    }
    
    private func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(RentTypeCell.self, forCellWithReuseIdentifier: RentTypeCell.identifier)
        collectionView.register(SearchPropertyCell.self, forCellWithReuseIdentifier: SearchPropertyCell.identifier)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(6)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeCellTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = homeCellTypes[indexPath.row]
        
        switch cellType {
        case .propertyType(_):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RentTypeCell.identifier, for: indexPath) as! RentTypeCell
            return cell
        case .propertySearch(_):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPropertyCell.identifier, for: indexPath) as! SearchPropertyCell
            return cell
        case .propertyCategory(_):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            return cell
        case .featuredPost(_):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            return cell
        case .propertyList(_):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPropertyCell.identifier, for: indexPath) as! SearchPropertyCell
            return cell
        case .latestAnnouncements(_):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPropertyCell.identifier, for: indexPath) as! SearchPropertyCell
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellType = homeCellTypes[indexPath.row]
        
        switch cellType {
        case .propertyType(_):
            return CGSize(width: collectionView.frame.width, height: 110)
        case .propertySearch(_):
            return CGSize(width: collectionView.frame.width, height: 70)
        case .propertyCategory(_):
            return CGSize(width: collectionView.frame.width, height: 90)
        case .featuredPost(_), .propertyList(_), .latestAnnouncements(_):
            return CGSize(width: collectionView.frame.width, height: 120)
        }
    }
}
