//
//  CreatePostController.swift
//  Haus
//
//  Created by Ilahe Samedova on 22.06.24.
//

import UIKit
import SnapKit

class CreatePostController: UIViewController {
    
    private var isExpanded: Bool = false
    private let mainPropertyView = MainPropertyView()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        
        let bulletPoints = """
            • Xidmətimizi sınamağınız üçün sizə ay ərzində 2 elanı pulsuz yerləşdirmək imkanı təqdim edirik. Ay ərzində hər növbəti elan üçün ödəniş 5 AZN təşkil edir.
            • Eyni elanın təkrar paylaşılması qadağandır.
            • Elanın məzmununu başqa bir elanla əvəz etmək qadağandır.
            """
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        
        let attributedString = NSAttributedString(
            string: bulletPoints,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor.black
            ]
        )
        
        label.attributedText = attributedString
        return label
    }()
    
    private lazy var expandButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Daha çox", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(toggleInfoLabel), for: .touchUpInside)
        return button
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chevronDown")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Yeni elan yarat."
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        view.addSubview(infoLabel)
        view.addSubview(expandButton)
        view.addSubview(chevronImageView)
        view.addSubview(mainPropertyView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        let stackView = UIStackView(arrangedSubviews: [expandButton, chevronImageView])
        stackView.axis = .horizontal
        stackView.spacing = 4
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(infoLabel).offset(7)
            make.trailing.equalTo(infoLabel).offset(-16)
        }
        
        mainPropertyView.snp.makeConstraints { make in
                    make.top.equalTo(infoLabel.snp.bottom).offset(16)
                    make.leading.trailing.equalToSuperview()
                    make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(-16)
                }
    }
    
    @objc private func toggleInfoLabel() {
        isExpanded.toggle()
        
        UIView.animate(withDuration: 0.3) {
            self.infoLabel.numberOfLines = self.isExpanded ? 0 : 3
            self.expandButton.setTitle(self.isExpanded ? "Daha az" : "Daha çox", for: .normal)
            self.chevronImageView.image = UIImage(named: self.isExpanded ? "chevronUp" : "chevronDown")
            self.view.layoutIfNeeded()
        }
    }
}
