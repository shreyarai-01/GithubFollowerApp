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
        configureMessageLabel()
        configureLogoImageView()
    }
    
    private func configureMessageLabel() {
        addSubview(messageLabel)
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        let labelCenterYConstant: CGFloat = (DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed) ? -90 : -150
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func configureLogoImageView() {
        addSubview(logoImage)
        
        logoImage.image = Images.emptyState
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        
        let logoBottomConstant: CGFloat = (DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed) ? 100 : 40
        
        NSLayoutConstraint.activate([
            logoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant)
        ])
    }
}
