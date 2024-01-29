
import UIKit

class AgentAccountController: UIViewController{
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.text = "Agentliyin e-poçt ünvanı adı, platformada istifadə edəcəyiniz istifadəçi adı və agentlik haqqında qısa məlumat daxil edin."
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-poçt ünvanı"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    let nameOrAgencyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Adınız/Agentlik adı"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "@istifadəçi adı"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    let aboutTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Haqqında (məcburi deyil)"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.contentVerticalAlignment = .top
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
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
        
        view.addSubview(nameOrAgencyTextField)
        nameOrAgencyTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
        
        view.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameOrAgencyTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
        
        view.addSubview(aboutTextField)
        aboutTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(124)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(aboutTextField.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        nextButton.isEnabled = !(emailTextField.text?.isEmpty ?? true) && !(nameOrAgencyTextField.text?.isEmpty ?? true) && !(userNameTextField.text?.isEmpty ?? true)
    }
    
    func goToAccountScreen() {
        let vc = AgentPhotoController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
