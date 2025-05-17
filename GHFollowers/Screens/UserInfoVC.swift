import UIKit
import SafariServices

protocol UserInfoVCDelegate : AnyObject {
    
    func didRequestFollower(for user: String)
}

class UserInfoVC: GFDataLoadingVC {
    var itemViews :[UIView] = []
    var username: String!
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    weak var delegate : UserInfoVCDelegate!
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        layoutUI()
        getUserInfo()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func layoutUI() {
        let padding :CGFloat = 20
        let itemHEIGHT:CGFloat = 140
        itemViews = [headerView, itemViewOne, itemViewTwo,dateLabel]
        for item in itemViews {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
                item.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHEIGHT),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHEIGHT),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: 15),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo () {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user) :
                DispatchQueue.main.async {
                    self.configureUIElement(with: user)
                }
                
            case .failure(let error) :
                self.presentGFAlertOnMainThread(title: "Ooh", message: error.rawValue, buttonTitle: "ok")
            }
        }
    }
    
    func configureUIElement(with user: User) {
        DispatchQueue.main.async {
            let repoItemVC = GFRepoItemVC(user: user)
            repoItemVC.delegate = self
            
            let followerItemVC = GfFollowerItemVC(user: user)
            followerItemVC.delegate = self
            self.add(childVC: repoItemVC, to: self.itemViewOne)
            self.add(childVC: followerItemVC, to: self.itemViewTwo)
            self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
            self.dateLabel.text = "Github since \( user.createdAt.convertToMonethYearFormat())"
        }
    }
    
    @objc func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
    
    func add(childVC : UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

extension UserInfoVC: ItemInfoVcDelegate{
    func didTapGitProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else{
            presentGFAlertOnMainThread(title: "Invalid User", message: "The url attached to this user is invalid !!! do something", buttonTitle: "ok")
            return
        }
        presentSafariVC(with: url)
    }
    
    func didTapGetFolowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "User does not have any follower .. sad !!", buttonTitle: "Ok")
            return
        }
        let followerListVC = FollowerListVC(userName: user.login)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
}
