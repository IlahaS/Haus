//
//  MainPropertyView.swift
//  Haus
//
//  Created by Ilahe Samedova on 27.06.24.
//

import UIKit

class MainPropertyView: UIView {
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Əmlakı"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private lazy var sellButton: UIButton = {
        let button = createButton(withTitle: "Satıram")
        button.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        return button
    }()
    
    private lazy var rentButton: UIButton = {
        let button = createButton(withTitle: "Kirayə verirəm")
        button.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        return button
    }()
    
    private lazy var dailyRentButton: UIButton = {
        let button = createButton(withTitle: "Gündəlik Kirayə verirəm")
        button.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        return button
    }()
    
    private func createButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.snp.makeConstraints { make in
            make.width.equalTo(176)
        }
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let buttons = [sellButton, rentButton, dailyRentButton]
        buttons.forEach { button in
            if button == sender {
                button.backgroundColor = .systemBlue
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .lightGray
                button.setTitleColor(.black, for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        let horizontalStackView = UIStackView(arrangedSubviews: [sellButton, rentButton])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        
        let verticalStackView = UIStackView(arrangedSubviews: [horizontalStackView, dailyRentButton])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        
        addSubview(titleLabel)
        addSubview(verticalStackView)
        
        setupConstraints(horizontalStackView: horizontalStackView, verticalStackView: verticalStackView)
    }
    
    private func setupConstraints(horizontalStackView: UIStackView, verticalStackView: UIStackView) {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
