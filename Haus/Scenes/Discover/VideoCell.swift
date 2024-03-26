//
//  VideoCell.swift
//  Hous
//
//  Created by Ilahe Samedova on 20.02.24.
//
import UIKit
import SnapKit
import AVFoundation

class VideoCell: UICollectionViewCell {
    static let identifier = "VideoCell"
    var viewModel = DiscoverViewModel()
    var player: AVPlayer?
    
    var playerView: AVPlayerLayer! = {
        let view = AVPlayerLayer()
        return view
    }()
    
    var logoImageView: UIImageView! = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .gray
        image.image = UIImage(named: "profileLogo")
        image.layer.cornerRadius = 17
        return image
    }()
    
    var titleLabel: UILabel! = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.text = "@realemlak.00"
        return label
    }()
    
    var actionButton: UIButton! = {
        let button = UIButton(type: .system)
        button.setTitle("Elana bax", for: .normal)
        button.backgroundColor = UIColor.gray
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.cornerRadius = 4
        return button
    }()
    
    var descriptionLabel: UILabel! = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    var shareButton: UIButton! = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var isDescriptionExpanded = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        
        //playerView
        contentView.layer.insertSublayer(playerView, at: 0)
        //progressView
        let progressBar = UIProgressView()
        progressBar.progressTintColor = .white
        progressBar.trackTintColor = .gray
        progressBar.progress = 0.5
        addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(2)
        }
        
        //shareStackView
        let shareLabel = UILabel()
        shareLabel.text = "Paylaş"
        shareLabel.font = .systemFont(ofSize: 12)
        shareLabel.textColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [shareButton, shareLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(40)
            make.height.equalTo(42)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(stackView.snp.leading).offset(-16)
        }
        
        
        addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(36)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-12)
            make.leading.equalToSuperview().offset(16)
        }
        

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(logoImageView.snp.trailing).offset(8)
            make.centerY.equalTo(logoImageView)
        }
        
        addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.width.equalTo(74)
            make.height.equalTo(24)
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.centerY.equalTo(logoImageView)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(descriptionLabelTapped))
        descriptionLabel.isUserInteractionEnabled = true
        descriptionLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func descriptionLabelTapped() {
        toggleDescriptionExpansion()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerView.frame = contentView.bounds
    }

    func configure(with video: Item, fileName: String) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "mp4") else {
            return
        }
        
        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        playerView.player = player
        playerView.frame = contentView.bounds
        playerView.videoGravity = .resizeAspectFill
        player?.volume = 0
        player?.play()
        
        self.titleLabel.text = "realemlak"
        self.descriptionLabel.text = video.description
    }

    
    func toggleDescriptionExpansion() {
        isDescriptionExpanded.toggle()
        if isDescriptionExpanded {
            descriptionLabel.numberOfLines = 0
        } else {
            descriptionLabel.numberOfLines = 2
        }
    }
}
