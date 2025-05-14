//
//  GFItemInfoView.swift
//  GHFollowers
//

import UIKit

enum ItemInfoType{
    case repos,gists,folowers,following
}

class GFItemInfoView: UIView {
    
    let symbolImage = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        addSubview(symbolImage)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImage.translatesAutoresizingMaskIntoConstraints=false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        symbolImage.tintColor = .black
        
        NSLayoutConstraint.activate([
            symbolImage.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImage.widthAnchor.constraint(equalToConstant: 20),
            symbolImage.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImage.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImage.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant:18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImage.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    func set(iteminfo: ItemInfoType, withCnt count : Int){
        
        switch iteminfo{
        case .repos :
            symbolImage.image = Images.repos
            titleLabel.text = Texts.repoText
            countLabel.text = String(count)
            
        case .gists :
            symbolImage.image = Images.gists
            titleLabel.text = Texts.gistText
            countLabel.text = String(count)
            
        case .folowers :
            symbolImage.image = Images.follower
            titleLabel.text = Texts.followerText
            countLabel.text = String(count)
            
        case .following :
            symbolImage.image = Images.following
            titleLabel.text = Texts.followingtext
            countLabel.text = String(count)
        }
    }
}
