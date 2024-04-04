import UIKit

class TitleView: UIView {    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@realemlak.00"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus_rectangle"), for: .normal)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "setting"), for: .normal)
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHeaderView() {
        addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        headerView.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(headerView).offset(16)
        }
        
        headerView.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(headerView).offset(-16)
            make.height.equalTo(24)
        }
        
        headerView.addSubview(plusButton)
        plusButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
            make.trailing.equalTo(settingsButton.snp.leading).offset(-24)
        }
    }
    @objc private func plusButtonTapped() {
        print("plus button tapped")
    }
    
    @objc private func settingsButtonTapped() {
        
    }
}
