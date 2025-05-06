//
//  GFItemInfoVC.swift
//  GHFollowers
//

import UIKit

class GFItemInfoVC: UIViewController {

    weak var delegate:UserInfoVcDelegate!
    var userr : User!
    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionBtn = GFButton()
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.userr = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureBG()
        configureActionButton()
        layoutUI()
        configureStackView()
        
    }
    
    func configureBG(){
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    func layoutUI(){
        view.addSubview(stackView)
        view.addSubview(actionBtn)
        view.addSubview(itemInfoViewOne)
        view.addSubview(itemInfoViewTwo)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor,constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionBtn.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }
    
    func configureStackView(){
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    private func configureActionButton(){
        
        actionBtn.addTarget(self, action: #selector(actionBtnTyped), for: .touchUpInside)
    }
    
    @objc func actionBtnTyped(){
        
    }

}
