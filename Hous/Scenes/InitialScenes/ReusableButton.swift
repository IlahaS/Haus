
import UIKit
import SnapKit

class ReusableButton: UIButton{
    
    private var title: String
    private var onAction: () -> Void
    private var color: UIColor
    
    override init(frame: CGRect) {
        title = ""
        color = .mainBlueColor
        onAction = {}
        super.init(frame: frame)
    }
    
    convenience init(
        title: String,
        color: UIColor,
        onAction: @escaping () -> Void
    ) {
        self.init(frame: .zero)
        self.title = title
        self.onAction = onAction
        self.color = color
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        backgroundColor = color
        layer.cornerRadius = 10
        layer.masksToBounds = true
        setTitle(title, for: .normal)
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
    }
    
    @objc private func buttonClicked(){
        onAction()
    }
    
}
