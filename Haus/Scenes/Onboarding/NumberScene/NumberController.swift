
import UIKit
import SnapKit
import SkyFloatingLabelTextField

class NumberController: UIViewController , UITextFieldDelegate  {
    
    var viewModel = NumberViewModel(builder: UserBuilder())
    
    convenience init(viewModel: NumberViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.text = "Giriş üçün nömrənizə birdəfəlik kod göndəriləcək."
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let flagImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "flag")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    let breakContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    let countryNumLabel: UILabel = {
        let label = UILabel()
        label.text = "+944"
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let mobileNumberTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Mobil nömrə"
        textField.keyboardType = .phonePad
        textField.selectedTitleColor = .grayColor
        textField.lineColor = .grayColor
        textField.lineHeight = 0.0
        textField.lineView.isHidden = true
        return textField
    }()
    
    let termsAndPrivacyTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .center
        return textView
    }()
    
    private lazy var nextButton: ReusableButton = {
        let button = ReusableButton(title: "Davam et", color: .mainBlueColor) {
            self.goToOTPScreen()
        }
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        nextButton.isEnabled = false
        nextButton.backgroundColor = .grayColor3
        login()
        setupUI()
        setTermsAndPrivacyText()
        
        mobileNumberTextField.delegate = self
        
    }
    
    @objc func goToOTPScreen() {
        guard let mobileNumber = mobileNumberTextField.text else { return }
        
        if mobileNumber.count >= 12 {
            viewModel.updateMobileNumber(mobileNumber)
            let otpController = OtpController(viewModel: .init(builder: viewModel.userBuilder))
            otpController.viewModel.mobileNumber = mobileNumber
            
            DatabaseAdapter().saveMobileNumberToKeychain(mobileNumber: mobileNumber)
            
            mobileNumberTextField.tintColor = .black
            navigationController?.pushViewController(otpController, animated: true)
        } else {
            nextButton.isEnabled = false
        }
    }
    
    
    
    func login() {
        UserDefaults.standard.setValue(true, forKey: "loggedIn")
    }
    
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Mobil nömrənizi daxil edin."
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
        
        view.addSubview(containerView)
        containerView.addSubview(countryNumLabel)
        containerView.addSubview(mobileNumberTextField)
        containerView.addSubview(breakContainerView)
        containerView.addSubview(flagImage)
        
        flagImage.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        
        countryNumLabel.snp.makeConstraints { make in
            make.leading.equalTo(flagImage.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(47)
        }
        
        breakContainerView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(countryNumLabel.snp.trailing).offset(8)
        }
        
        mobileNumberTextField.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalToSuperview().inset(6)
            make.bottom.equalToSuperview().inset(16)
            
            make.leading.equalTo(breakContainerView.snp.trailing).offset(12)
        }
        
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(containerView.snp.bottom).offset(24)
        }
        
        view.addSubview(termsAndPrivacyTextView)
        termsAndPrivacyTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(nextButton.snp.bottom).offset(16)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        
        let startsWithValidPrefix = newText.hasPrefix("70") || newText.hasPrefix("55") || newText.hasPrefix("50") || newText.hasPrefix("51")
        let isValidLength = newText.count >= 12
        
        nextButton.isEnabled = startsWithValidPrefix && isValidLength
        nextButton.backgroundColor = nextButton.isEnabled ? .mainBlueColor : .grayColor3
        
        textField.text = String.format(with: "XX XXX XX XX", phone: newText)
        
        viewModel.updateMobileNumber(newText)
        
        return false
    }
    
    
    func setTermsAndPrivacyText() {
        let termsLink = "İstifadə Qaydaları"
        let privacyLink = "Məxfilik Siyasəti"
        
        let text = "Giriş etməklə siz platformanın \(termsLink) və \(privacyLink) ilə razılaşırsınız."
        let attributedString = NSMutableAttributedString(string: text)
        
        
        let termsRange = (text as NSString).range(of: termsLink)
        attributedString.addAttribute(.link, value: "terms://", range: termsRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.mainBlue, range: termsRange)
        
        let privacyRange = (text as NSString).range(of: privacyLink)
        attributedString.addAttribute(.link, value: "privacy://", range: privacyRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.mainBlue, range: privacyRange)
        
        termsAndPrivacyTextView.attributedText = attributedString
        termsAndPrivacyTextView.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.mainBlue,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        termsAndPrivacyTextView.delegate = self
    }
}

extension NumberController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        
        if URL.scheme == "terms" {
        } else if URL.scheme == "privacy" {
        }
        
        return false
    }
}
