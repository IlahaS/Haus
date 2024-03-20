//
//  VideoCell.swift
//  Hous
//
//  Created by Ilahe Samedova on 20.02.24.
//
import UIKit
import SnapKit


class VideoCell: UICollectionViewCell {
    static let identifier = "VideoCell"
    
    var playerView: UIView!
    var logoImageView: UIImageView!
    var titleLabel: UILabel!
    var actionButton: UIButton!
    var descriptionLabel: UILabel!
    var shareButton: UIButton!
    
    var isDescriptionExpanded = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        
        playerView = UIView()
        addSubview(playerView)
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let progressBar = UIProgressView()
        progressBar.progressTintColor = .white
        progressBar.trackTintColor = .gray
        progressBar.progress = 0.5
        
        addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(2)
        }
        
        shareButton = UIButton(type: .system)
        addSubview(shareButton)
        shareButton.setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        shareButton.tintColor = .white
        
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
        
        descriptionLabel = UILabel()
        addSubview(descriptionLabel)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 2
        descriptionLabel.text = "Şüvəlan qəsəbəsində Şimal DRES elektrik stansiyası tərəfdə düz yolun qırağında ümumi torpaq sahəsi 11 sot olan 2-mərtəbəli, 9 otaqdan (6 yataq otağı), 2 sanuzeldən ibarət olan BAĞ EVİ SATILIR! Evdə hər bir şərait mövcuddur və Dənizə 5 dəqiqəlik məsafədədir."
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(stackView.snp.leading).offset(-16)
        }
        
        logoImageView = UIImageView()
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.backgroundColor = .gray
        logoImageView.layer.cornerRadius = 17
        
        addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(36)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-12)
            make.leading.equalToSuperview().offset(16)
        }
        
        
        titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 14)
        
        titleLabel.text = "@realemlak.00"
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(logoImageView.snp.trailing).offset(8)
            make.centerY.equalTo(logoImageView)
        }
        
        actionButton = UIButton(type: .system)
        actionButton.setTitle("Elana bax", for: .normal)
        actionButton.backgroundColor = UIColor.gray
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.titleLabel?.font = .systemFont(ofSize: 12)
        actionButton.layer.cornerRadius = 4
        
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
    
    func configure(with video: Item) {
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
