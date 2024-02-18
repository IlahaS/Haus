import SnapKit
import UIKit

class SelectAccountController: UIViewController{
    
    var viewModel: SelectAccountViewModel
    
    init(viewModel: SelectAccountViewModel, builder: UserBuilder) {
        self.viewModel = viewModel
        self.viewModel.builder = builder
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.text = "Başlamaq üçün bir neçə bəsit məlumat kifayətdir."
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //collectionView.backgroundColor = .gray
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AccountTypeCell.self, forCellWithReuseIdentifier: AccountTypeCell.identifier)
        
        return collectionView
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "İstifadəçi kateqoriyası:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    private lazy var nextButton: ReusableButton = {
        let button = ReusableButton(title: "Davam et", color: .mainBlueColor) {
            self.goToAccountScreen()
        }
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "1/3 Yeni hesab yaradın."
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        view.addSubview(descLabel)
        view.addSubview(categoryLabel)
        view.addSubview(collectionView)
        view.addSubview(nextButton)
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(12)
            make.height.equalTo(164)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
    }
    private func toggleButtonState(for accountType: AccountType) {
        guard let index = viewModel.selectedAccountType.firstIndex(of: accountType) else {
            return
        }

        viewModel.selectedAccountIndex = index
        collectionView.reloadData()
        nextButton.isEnabled = true
    }
    
    
    private func presentViewControllerFor(accountType: AccountType, builder: UserBuilder) {
        switch accountType {
        case .personal:
            let personalVC = PersonalAccountController(viewModel: .init(builder: viewModel.builder), builder: viewModel.builder)
            navigationController?.pushViewController(personalVC, animated: true)
        case .agent:
            let agentVC = AgentAccountController()
            agentVC.builder = builder
            navigationController?.pushViewController(agentVC, animated: true)
        }
    }
    
    func goToAccountScreen() {
        if let selectedAccountIndex = viewModel.selectedAccountIndex {
            let builder = viewModel.builder.withAccountType(viewModel.selectedAccountType[selectedAccountIndex])
            
            presentViewControllerFor(accountType: viewModel.selectedAccountType[selectedAccountIndex], builder: builder)
        }
    }
}

extension SelectAccountController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2-5 , height: 164)
    }
    
}

extension SelectAccountController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.selectedAccountType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccountTypeCell.identifier, for: indexPath) as? AccountTypeCell else {
            return UICollectionViewCell()
        }
        
        let accountType = viewModel.selectedAccountType[indexPath.item]
        let isSelected = indexPath.item == viewModel.selectedAccountIndex
        cell.configure(for: accountType, isSelected: isSelected)
        cell.backgroundColor = .grayColor2
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        toggleButtonState(for: AccountType(rawValue: indexPath.item) ?? .personal)
    }
    
}

class AccountTypeCell: UICollectionViewCell {
    static let identifier = "AccountTypeCell"
    
    private let symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .grayColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.addSubview(symbolImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        symbolImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(28)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(symbolImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configure(for accountType: AccountType, isSelected: Bool) {
        
        switch accountType {
        case .personal:
            symbolImageView.image = UIImage(systemName: "person.fill")
            titleLabel.text = "Fərdi"
            descriptionLabel.text = "Vasitəçi fəaliyyəti göstərməyən şəxslər üçün hesab."
        case .agent:
            symbolImageView.image = UIImage(systemName: "house.fill")
            titleLabel.text = "Agent"
            descriptionLabel.text = "Evlərin alqı-satqısı ilə məşğul olan şəxs və şirkətlər üçün hesab."
        }
        
        contentView.backgroundColor = isSelected ? .mainBlueColor : .clear
        symbolImageView.tintColor = isSelected ? .white : .black
        titleLabel.textColor = isSelected ? .white : .black
        descriptionLabel.textColor = isSelected ? .white : .grayColor
        contentView.layer.cornerRadius = 10
    }
    
}

