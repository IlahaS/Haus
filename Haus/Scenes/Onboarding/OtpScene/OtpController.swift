import UIKit
import SnapKit

class OtpController: UIViewController {
   
    var viewModel = OtpViewModel()
    
    var enteredOTP = "" {
        didSet {
            updateNextButtonState()
        }
    }
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle( "Yeni kod göndər", for: .normal)
        button.setTitleColor(.mainBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(sendOtpAgain), for: .touchUpInside)

        return button
    }()
    
    init(viewModel: OtpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        nextButton.isEnabled = false
        nextButton.backgroundColor = .gray
        
        setupUI()
        
        if let mobileNumber = viewModel.mobileNumber {
            let attributedString = NSMutableAttributedString(string: "Kod \(mobileNumber) nömrəsinə göndəriləcək.")
            let range = (attributedString.string as NSString).range(of: mobileNumber)
            attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: range)
            
            descLabel.attributedText = attributedString
        }
    }
    
    private lazy var nextButton: ReusableButton = {
        let button = ReusableButton(title: "Təsdiqlə", color: .mainBlueColor) {
            self.goToAccountScreen()
        }
        button.isEnabled = false
        return button
    }()
    
    @objc func goToAccountScreen() {
        let accountController = SelectAccountController(viewModel: .init(builder: viewModel.builder), 
                                                        builder: viewModel.builder)
        navigationController?.pushViewController(accountController, animated: true)
    }
    
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Birdəfəlik kodu daxil edin."
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
        containerView.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 32, bottom: 8, right: 32))
        }
        
        stackView.distribution = .fillEqually
        
        for _ in 1...4 {
            let dotContainer = createDotContainer()
            stackView.addArrangedSubview(dotContainer)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(containerView.snp.bottom).offset(24)
        }
        
        view.addSubview(tryAgainButton)
        tryAgainButton.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(120)
            make.height.equalTo(20)
        }
        
        viewModel.enteredOTP = enteredOTP
    }
    
    private func updateNextButtonState() {
        
        nextButton.isEnabled = enteredOTP.count == 4
        nextButton.backgroundColor = enteredOTP.count == 4 ? .mainBlueColor : .gray
    }
    
    func createDotContainer() -> UIView {
        let dotContainer = UIView()
        
        let dotLabel: UILabel = {
            let label = UILabel()
            label.text = "●"
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = .grayColor
            return label
        }()
        
        let textField: UITextField = {
            let textField = UITextField()
            textField.textAlignment = .center
            textField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            textField.textColor = .black
            
            textField.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
            textField.delegate = self
            return textField
        }()
     
        
        dotContainer.addSubview(dotLabel)
        dotLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        dotContainer.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return dotContainer
    }
    
    @objc func textFieldEditingDidBegin(_ textField: UITextField) {
        if let dotLabel = (textField.superview?.subviews.compactMap { $0 as? UILabel })?.first {
            dotLabel.isHidden = true
        }
    }
    
    @objc func sendOtpAgain() {
        enteredOTP = ""

    }
}
    
extension OtpController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return false }
        
        let isNumber = string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        
        if !isNumber {
            return false
        }
        
        textField.text = isNumber ? string : ""
        
        if string.isEmpty {
            textField.text = ""
        } else {
            let newText = currentText + string
            textField.text = newText
            
            if let dotLabel = (textField.superview?.subviews.compactMap { $0 as? UILabel })?.first {
                dotLabel.text = string
            }
            
            if newText.count >= 1, let nextTextField = findNextTextField(after: textField) {
                nextTextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
        
        enteredOTP = stackView.arrangedSubviews.compactMap {
            ($0.subviews.compactMap { ($0 as? UITextField)?.text ?? "" }).joined()
        }.joined()
        
        return false
    }
    
    func findNextTextField(after textField: UITextField) -> UITextField? {
        guard let index = stackView.arrangedSubviews.firstIndex(where: { ($0).subviews.contains(textField) }),
              index < stackView.arrangedSubviews.count - 1 else {
            nextButtonAction()
            return nil
        }
        
        let nextContainer = stackView.arrangedSubviews[index + 1]
        return nextContainer.subviews.compactMap { $0 as? UITextField }.first
    }
    
    private func nextButtonAction() {
        goToAccountScreen()
    }
}
