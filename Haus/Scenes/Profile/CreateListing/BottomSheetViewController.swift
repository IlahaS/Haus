//
//  InitialListScreen.swift
//  Haus
//
//  Created by Ilahe Samedova on 15.04.24.
//
import UIKit
import SnapKit

protocol BottomSheetViewControllerDelegate: AnyObject {
    func bottomSheetDidDismiss()
    func didTapHomeButton()
}

class BottomSheetViewController: UIViewController {
    
    weak var delegate: BottomSheetViewControllerDelegate?
    
    private lazy var homeButtonView: ImageButton = {
        let buttonView = ImageButton()
        buttonView.title = "Elanlar"
        buttonView.image = UIImage(named: "HomeBlack")
        buttonView.iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        buttonView.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        return buttonView
    }()
    
    private lazy var discoverButtonView: ImageButton = {
        let buttonView = ImageButton()
        buttonView.title = "Postlar"
        buttonView.image = UIImage(named: "DiscoverBlack")
        buttonView.iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        buttonView.addTarget(self, action: #selector(discoverButtonTapped), for: .touchUpInside)
        return buttonView
    }()
    
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .grayColor2
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
        }
        
        containerView.addSubview(homeButtonView)
        containerView.addSubview(lineView)
        containerView.addSubview(discoverButtonView)
        
        homeButtonView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(homeButtonView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        discoverButtonView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
    }
    
    @objc func homeButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.didTapHomeButton()
        }
    }
    
    @objc func discoverButtonTapped() {
        print("discover button tapped")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.bottomSheetDidDismiss()
    }
}
