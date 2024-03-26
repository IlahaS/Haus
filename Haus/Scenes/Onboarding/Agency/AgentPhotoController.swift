

import UIKit

class AgentPhotoController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    var builder = UserBuilder()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.text = "Agentliyi təsvir edən bir foto yükləyin. Bu, agentliyin yeni profil fotosu olacaq."
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let personImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = .grayColor2
            imageView.layer.cornerRadius = 86
            imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
            return imageView
        }()

    let personSymbol: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "person.fill")
            imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
            return imageView
        }()
    
    private lazy var plusButton: UIButton = {
            let button = UIButton(type: .system)
        button.backgroundColor = .mainBlueColor
        button.layer.cornerRadius = 20
            button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
            return button
        }()
    
    let plusSymbol: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "plus")
            imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
            return imageView
        }()
    
    private lazy var nextButton: ReusableButton = {
        let button = ReusableButton(title: "Davam et", color: .mainBlueColor) {
            self.goToAccountScreen()
        }
        //button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "3/3 Yeni hesab yaradın."
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
        
        view.addSubview(personImageView)
        personImageView.snp.makeConstraints { make in
            make.width.height.equalTo(172)
            make.centerX.equalToSuperview()
            make.top.equalTo(descLabel.snp.bottom).offset(80)
        }
        
        view.addSubview(personSymbol)
        personSymbol.snp.makeConstraints { make in
            make.height.width.equalTo(80)
            make.centerX.centerY.equalTo(personImageView)
        }
        
        view.addSubview(plusButton)
            plusButton.snp.makeConstraints { make in
                make.width.height.equalTo(40)
                make.bottom.trailing.equalTo(personImageView).offset(-8)
            }
        
        view.addSubview(plusSymbol)
        plusSymbol.snp.makeConstraints { make in
            make.height.width.equalTo(22)
            make.centerX.centerY.equalTo(plusButton)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(personImageView.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
    }
    
    @objc func plusButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera not available")
            }
        }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { _ in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func goToAccountScreen(){
        let scene = self.sceneDelegate
        scene?.switchToTabViewController()
    }
}

//extension UIViewController {
//    var appDelegateAgent: AppDelegate {
//        return UIApplication.shared.delegate as! AppDelegate
//    }
//    
//    var sceneDelegateAgent: SceneDelegate? {
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let delegate = windowScene.delegate as? SceneDelegate else { return nil }
//        return delegate
//    }
//}

extension AgentPhotoController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            personImageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            personImageView.image = originalImage
        }
        personSymbol.isHidden = true
        dismiss(animated: true, completion: nil)
        
        nextButton.isEnabled = true
        nextButton.backgroundColor = .mainBlueColor
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
