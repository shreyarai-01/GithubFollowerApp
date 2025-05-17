//
//  GFDataLoadingVC.swift
//  GHFollowers
//
//  Created by NRI-Mac4 on 08/05/25.
//  Copyright © 2025 Sean Allen. All rights reserved.
//

import UIKit

class GFDataLoadingVC: UIViewController {
    
    var containerView : UIView!
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView(){
        DispatchQueue.main.async{
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyStateView(with mesage: String, in view : UIView) {
        let emptyStateView = GFEmptyStateView(message: mesage)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
