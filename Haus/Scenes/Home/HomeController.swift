import UIKit
import SnapKit

protocol ConfigurableCell{
    static var identifier: String { get set }
    
    func configure()
}

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
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
            self?.collectionView.reloadData()
        }
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
        collectionView.register(PropertyCell.self, forCellWithReuseIdentifier: PropertyCell.identifier)
        collectionView.register(FuturedCell.self, forCellWithReuseIdentifier: FuturedCell.identifier)
        collectionView.register(LatestCell.self, forCellWithReuseIdentifier: LatestCell.identifier)
        
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(6)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = viewModel.cellType(at: indexPath.row)
        
        switch cellType {
        case .propertyType(_):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RentTypeCell.identifier, for: indexPath) as! RentTypeCell
            return cell
        case .propertySearch(_):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPropertyCell.identifier, for: indexPath) as! SearchPropertyCell
            return cell
        case .propertyCategory(let propertyTypes):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            cell.configure(with: propertyTypes ?? [])
            return cell
        case .featuredPost(_):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FuturedCell.identifier, for: indexPath) as! FuturedCell
            return cell
            
        case .propertyList(let property):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PropertyCell.identifier, for: indexPath) as! PropertyCell
            cell.property = property ?? []
            if let latestPost = property?[safe: indexPath.row] {
                    cell.latestPost = latestPost
                }
            //print(cell.property.count)
            
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
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellType = viewModel.cellType(at: indexPath.row)
        
        switch cellType {
        case .propertyType(_):
            return CGSize(width: collectionView.frame.width, height: 110)
        case .propertySearch(_):
            return CGSize(width: collectionView.frame.width, height: 70)
        case .propertyCategory(_):
            return CGSize(width: collectionView.frame.width, height: 90)
        case .featuredPost(_):
            return CGSize(width: collectionView.frame.width, height: 250)
        case .propertyList(_):
            return CGSize(width: collectionView.frame.width, height: 487)
        case .latestAnnouncements(_):
            return CGSize(width: collectionView.frame.width, height: 485)
        }
    }
}
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
