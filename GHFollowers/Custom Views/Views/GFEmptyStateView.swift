//
//  GFEmptyStateView.swift
//  GHFollowers

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(message: String){
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
        
    }
    
    private func configure(){
        addSubview(messageLabel)
        addSubview(logoImage)
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        logoImage.image = Images.emptyState
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        
        let labelCenterYConstant: CGFloat = (DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed) ? -90 : -150
        let messageLabelCenterY = messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant)
        messageLabelCenterY.isActive = true
      
        let logoBottomConstant: CGFloat = (DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed) ? 100 : 40
        let logoImageViewBottom = logoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant)
        logoImageViewBottom.isActive = true
        
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            logoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170)
        ])
    }
    
}
