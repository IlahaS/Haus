//
//  VideoCell.swift
//  Hous
//
//  Created by Ilahe Samedova on 20.02.24.
//

import Foundation
import UIKit
class VideoCell: UICollectionViewCell {
    static let identifier = "VideoCell"

    var playerView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .green
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSubviews() {
        
        playerView = UIView()
        addSubview(playerView)
        playerView.frame = bounds
    }

    func configure(with videoURL: String) {
        
        playerView.backgroundColor = UIColor.random()
    }
}
