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
            symbolImage.image = UIImage(systemName: "folder")
            titleLabel.text = "Public Repos"
            countLabel.text = String(count)
            
        case .gists :
            symbolImage.image = UIImage(systemName: "text.alignleft")
            titleLabel.text = "Public Gists"
            countLabel.text = String(count)
            
        case .folowers :
            symbolImage.image = UIImage(systemName: "heart")
            titleLabel.text = "Followers"
            countLabel.text = String(count)
            
        case .following :
            symbolImage.image = UIImage(systemName: "person.2")
            titleLabel.text = "Following"
            countLabel.text = String(count)
        }
    }
}
