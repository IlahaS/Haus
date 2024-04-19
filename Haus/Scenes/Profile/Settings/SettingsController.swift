//
//  SettingsController.swift
//  Haus
//
//  Created by Ilahe Samedova on 11.04.24.
//

import UIKit
import SnapKit

class SettingsController: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var userStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = -5
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "profileLogo")
        image.clipsToBounds = true
        image.layer.cornerRadius = 28
        return image
    }()
    
    private var personImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "person")
        return image
    }()
    
    private var accountInfo: UIButton = {
        let button = UIButton()
        button.setTitle("Hesab məlumatları", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private var bellImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "bell")
        return image
    }()
    
    private var notificationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Bildirişlər", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private var infoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "info_circle")
        return image
    }()
    
    private var useButton: UIButton = {
        let button = UIButton()
        button.setTitle("İstifadə Qaydaları", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private var lockImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "lock")
        return image
    }()
    
    private var privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Məxfilik Siyasəti", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private var logoutImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "logout")
        return image
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Çıxış", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(goToFirstScreen) , for: .touchUpInside)
        return button
    }()
    
    private var name: UILabel = {
        let label = UILabel()
        label.text = "Real Əmlak"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private var userName: UILabel = {
        let label = UILabel()
        label.text = "@realemlak.00"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .grayColor3
        return label
    }()
    
    private var secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var thirdView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var fourthView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .grayColor4
        return view
    }()
    
    private var lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = .grayColor4
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .grayColor5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Tənzimləmələr"
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        stackView.addArrangedSubview(firstView)
        firstView.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        firstView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(56)
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }
        view.addSubview(userStackView)
        userStackView.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(14)
            make.top.bottom.equalTo(imageView)
        }
        userStackView.addArrangedSubview(name)
        userStackView.addArrangedSubview(userName)
        
        stackView.addArrangedSubview(secondView)
        secondView.snp.makeConstraints { make in
            make.height.equalTo(112)
        }
        secondView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        secondView.addSubview(personImage)
        personImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(24)
            make.bottom.equalTo(lineView.snp.bottom).offset(-16)
        }
        
        secondView.addSubview(accountInfo)
        accountInfo.snp.makeConstraints { make in
            make.top.bottom.equalTo(personImage)
            make.leading.equalTo(personImage.snp.trailing).offset(10)
        }
        
        secondView.addSubview(bellImage)
        bellImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(24)
            make.top.equalTo(lineView.snp.bottom).offset(16)
        }
        
        secondView.addSubview(notificationButton)
        notificationButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(bellImage)
            make.leading.equalTo(bellImage.snp.trailing).offset(10)
        }
        
        stackView.addArrangedSubview(thirdView)
        thirdView.snp.makeConstraints { make in
            make.height.equalTo(112)
        }
        thirdView.addSubview(lineView2)
        lineView2.snp.remakeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        thirdView.addSubview(infoImage)
        infoImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(24)
            make.bottom.equalTo(lineView2.snp.bottom).offset(-16)
        }
        
        thirdView.addSubview(useButton)
        useButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(infoImage)
            make.leading.equalTo(infoImage.snp.trailing).offset(10)
        }
        
        thirdView.addSubview(lockImage)
        lockImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(24)
            make.top.equalTo(lineView2.snp.bottom).offset(16)
        }
        
        thirdView.addSubview(privacyButton)
        privacyButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(lockImage)
            make.leading.equalTo(lockImage.snp.trailing).offset(10)
        }
        
        stackView.addArrangedSubview(fourthView)
        fourthView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        fourthView.addSubview(logoutImage)
        logoutImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        fourthView.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.leading.equalTo(logoutImage.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func goToFirstScreen() {
        let alert = UIAlertController(title: "Çıxış etmək istədiyinizdən əminsiniz?", message: "", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "İmtina et", style: .cancel)
        alert.addAction(cancelAction)
        
        let confirmAction = UIAlertAction(title: "Çıxış et", style: .destructive) { _ in
            UserDefaults.standard.removeObject(forKey: "loggedIn")
            
            UserStateObserver.shared.notifyLogoutObservers()
                        
            let scene = UIApplication.shared.connectedScenes.first { $0.activationState == .foregroundActive }
            if let delegate = scene?.delegate as? SceneDelegate {
                delegate.switchToFirstScreen()
            }
            
        }
        alert.addAction(confirmAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Logout", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
