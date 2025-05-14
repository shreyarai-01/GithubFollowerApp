//
//  FollowerCell.swift
//  GHFollowers

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    let padding:CGFloat = 8
    let avatarImageView = GFImageAvatarView(frame: .zero)
    let userNameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    private func configure() {
        addSubview(avatarImageView)
        addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    func set(follower : Follower){
        userNameLabel.text = follower.login
        NetworkManager.shared.downloadImage(from: follower.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async{
                self.avatarImageView.image = image
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
