import UIKit
import SnapKit
import SkeletonView

protocol ConfigurableCell {
    static var identifier: String { get set }
    
    func configure()
}

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    enum Section {
        case propertyType
        case propertySearch
        case propertyCategory
        case featuredPost
        case propertyList
        case latestAnnouncements
    }
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, HomeViewModel.HomeCellItem>!
    
    private var viewModel = HomeViewModel()
    
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
        fetchData()
    }
    
    private func setupUI() {
        setupSearchBar()
        configureCollectionViewLayout()
    }
    
    private func fetchData() {
        viewModel.fetchData()
        viewModel.error = { errorMessage in
            print("Error: \(errorMessage)")
        }
        viewModel.success = { [weak self] in
            self?.collectionView.hideSkeleton()
            self?.collectionView.reloadData()
            self?.applySnapshot()
        }
    }
    
    private func setupSearchBar() {
        let notificationButton = UIButton.init(type: .system)
        notificationButton.setImage(UIImage(systemName: "bell"), for: .normal)
        notificationButton.contentMode = .scaleAspectFit
        notificationButton.tintColor = .black
        notificationButton.addTarget(self, action: #selector(goToNotificationScreen), for: .touchUpInside)
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
        collectionView.register(PropertyCell.self, forCellWithReuseIdentifier: PropertyCell.identifier)
        collectionView.register(FuturedCell.self, forCellWithReuseIdentifier: FuturedCell.identifier)
        collectionView.register(LatestCell.self, forCellWithReuseIdentifier: LatestCell.identifier)
        
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(6)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, HomeViewModel.HomeCellItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, cellType: HomeViewModel.HomeCellItem) -> UICollectionViewCell? in
            
            switch cellType {
            case .propertyType:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RentTypeCell.identifier, for: indexPath) as! RentTypeCell
                return cell
            case .propertySearch:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPropertyCell.identifier, for: indexPath) as! SearchPropertyCell
                return cell
            case .propertyCategory(let propertyTypes):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
                cell.configure(with: propertyTypes ?? [])
                return cell
            case .featuredPost:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FuturedCell.identifier, for: indexPath) as! FuturedCell
                return cell
            case .propertyList(let property):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PropertyCell.identifier, for: indexPath) as! PropertyCell
                cell.property = property ?? []
                if let latestPost = property?[safe: indexPath.row] {
                    cell.latestPost = latestPost
                }
                return cell
            case .latestAnnouncements(let latestProperty):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestCell.identifier, for: indexPath) as! LatestCell
                cell.property = latestProperty ?? []
                if let latestPost = latestProperty?[safe: indexPath.row] {
                    cell.latestPost = latestPost
                }
                return cell
            }
        }
    }
    
    @objc func goToNotificationScreen(){
        print("notif is clicked")
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, HomeViewModel.HomeCellItem>()
        
        snapshot.appendSections([.propertyType, .propertySearch, .propertyCategory, .featuredPost, .propertyList, .latestAnnouncements])
        
        for index in 0..<viewModel.numberOfItems() {
            let cellType = viewModel.cellType(at: index)
            
            switch cellType {
            case .propertyType:
                snapshot.appendItems([cellType], toSection: .propertyType)
            case .propertySearch:
                snapshot.appendItems([cellType], toSection: .propertySearch)
            case .propertyCategory:
                snapshot.appendItems([cellType], toSection: .propertyCategory)
            case .featuredPost:
                snapshot.appendItems([cellType], toSection: .featuredPost)
            case .propertyList:
                snapshot.appendItems([cellType], toSection: .propertyList)
            case .latestAnnouncements:
                snapshot.appendItems([cellType], toSection: .latestAnnouncements)
            }
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError()
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        let cellType = viewModel.cellType(at: indexPath.row)
        
        var numberOfItemsInSection = 0
        
        switch section {
        case 0: // Property Type
            numberOfItemsInSection = viewModel.propertyTypes?.count ?? 0
        case 1: // Property Search
            numberOfItemsInSection = 1
        case 2: // Property Category
            numberOfItemsInSection = viewModel.propertyCategories?.count ?? 0
        case 3: // Featured Post
            numberOfItemsInSection = viewModel.featuredPosts?.count ?? 0
        case 4: // Property List
            numberOfItemsInSection = viewModel.propertyList?.count ?? 0
        case 5: // Latest Announcements
            numberOfItemsInSection = viewModel.latestAnnouncements?.count ?? 0
        default:
            break
        }
        
        switch section {
        case 0: // Property Type
            return CGSize(width: collectionView.frame.width, height: 110)
        case 1: // Property Search
            return CGSize(width: collectionView.frame.width, height: 70)
        case 2: // Property Category
            return CGSize(width: collectionView.frame.width, height: 90)
        case 3: // Featured Post
            return CGSize(width: collectionView.frame.width, height: 250)
        case 4: // Property List
            return CGSize(width: collectionView.frame.width, height: CGFloat(numberOfItemsInSection) * 120 + 20)
        case 5: // Latest Announcements
            return CGSize(width: collectionView.frame.width, height: CGFloat(numberOfItemsInSection) * 120 + 20)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
