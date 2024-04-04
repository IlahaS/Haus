

import UIKit

class PersonalAccountController: UIViewController, UITextFieldDelegate{
    
    var viewModel: PersonalAccountViewModel
    
    init(viewModel: PersonalAccountViewModel, builder: UserBuilder) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.text = "Tam adınız və platformada istifadə edəcəyiniz istifadəçi adını daxil edin."
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Adınız"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "@istifadəçi adı"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
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
        userNameTextField.delegate = self
        
        setupUI()
    }
    
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "2/3 Yeni hesab yaradın."
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        view.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
        
        view.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
    }
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == userNameTextField {
            if textField.text?.isEmpty ?? true {
                textField.text = "@"
            }
        }
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == userNameTextField {
            if let text = textField.text {
                if text == "@" {
                    nextButton.isEnabled = false
                    nextButton.backgroundColor = .grayColor3
                } else if text.isEmpty {
                    nextButton.isEnabled = false
                    nextButton.backgroundColor = .grayColor3
                } else {
                    nextButton.isEnabled = true
                    nextButton.backgroundColor = .mainBlueColor
                }
            }
        } else {
            nextButton.isEnabled = !(nameTextField.text?.isEmpty ?? true) && !(userNameTextField.text?.isEmpty ?? true)
            nextButton.backgroundColor = nextButton.isEnabled ? .mainBlueColor : .grayColor3
        }
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == userNameTextField, let _ = textField.text, range.location == 0, range.length == 1, string.isEmpty {
            textField.text = "@"
            return false
        }
        return true
    }
    
    func goToAccountScreen() {
        let vc = PersonalPhotoController(builder: viewModel.builder
            .withName(nameTextField.text ?? "")
            .withUsername(userNameTextField.text ?? ""))
        navigationController?.pushViewController(vc, animated: true)
    }
}
