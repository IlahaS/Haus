
import UIKit
import SnapKit

class FirstController: UIViewController {

    let onboardingImg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "MainScreenLogo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let label1: UILabel = {
        let label = UILabel()

        
        let attributedText = NSMutableAttributedString(string: "Yeni evinizi",
                                                       attributes:
                                                        [.font: UIFont.boldSystemFont(ofSize: 24),
                                                         .foregroundColor: UIColor.black
                                                        ])
        
        
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 11))
        
//        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 24), range: NSRange(location: 0, length: 11))
//        
//        let paragraphStyle = NSMutableParagraphStyle()
//           paragraphStyle.lineHeightMultiple = 32.0 / UIFont.systemFont(ofSize: 24, weight: .bold).lineHeight
        
        attributedText.append(NSAttributedString(string: "\nbir neçə addımda tapın.", attributes: [
            .foregroundColor: UIColor.mainBlueColor,
//            .font: UIFont.boldSystemFont(ofSize: 24),
            .font: UIFont(name: "SFProDisplay-Bold", size: 24) ?? UIFont.boldSystemFont(ofSize: 24),
//            .paragraphStyle: paragraphStyle
        ]))
        
        label.textAlignment = .center
        label.attributedText = attributedText
        label.numberOfLines = 0
        
        return label
    }()

    
    let label2: UILabel = {
        let label = UILabel()
        label.text = "Axtardığınız ev indi sadəcə bir neçə video uzaqlıqdadır."
        label.textAlignment = .center
        label.textColor = .grayColor
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    
    private lazy var startButton: ReusableButton = {
        let button = ReusableButton(title: "Başla", color: .mainBlueColor) {
            self.goToNumberScreen()
        }
        return button
    }()
    
    @objc func goToNumberScreen() {
        let numberController = NumberController()
        navigationController?.pushViewController(numberController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        //startButton.addTarget(self, action: #selector(goToNumberScreen), for: .touchUpInside)
    }

    func setupUI(){
        view.addSubview(onboardingImg)
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(startButton)
        
        onboardingImg.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(170)
            make.top.equalToSuperview().offset(250)
        }
        
        label1.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)

            make.top.equalTo(onboardingImg.snp.bottom).offset(32)
            make.centerX.equalTo(onboardingImg)
            
        }
        
        label2.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
  
        startButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-40)
//            make.centerX.equalToSuperview()
        }
    }

}

