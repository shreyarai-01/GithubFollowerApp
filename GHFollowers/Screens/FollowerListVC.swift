import UIKit

protocol FollowerListVCDelegate : AnyObject {
    
    func didRequestFollower(for user: String)
}
class FollowerListVC: GFDataLoadingVC {
    
    
    enum Section {
        case main
    }
    var followers:[Follower] = []
    var username: String!
    var collectionView:UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var filteredFollower :[Follower] = []
    
    init(userName: String){
        super.init(nibName: nil, bundle: nil)
        self.username = userName
        title = userName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configureVC()
        configureCollectionView()
      //  configureSearchController()
        getFollowers(username: username, page: page)
        configureDataSource()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func configureVC() {
        view.backgroundColor = .systemBackground
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    @objc func addButtonTapped(){
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                let favor = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateWith(favorite: favor, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard let err = error else {
                        self.presentGFAlertOnMainThread(title: "Sucesss", message: "You have favourited ", buttonTitle: "Hooray")
                        return
                        
                    }
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: err.rawValue, buttonTitle: "Okk")
                    
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Smthing went wrong", message: error.rawValue, buttonTitle: "ok")
            }
        }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,collectionViewLayout: UIHelper.createThreeColumn(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        view.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView
    }
    func configureSearchController() {
        let searchController = UISearchController()
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = " Search for a user"
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func getFollowers(username : String, page: Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) {[weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result
            {
            case .success(let folowers) :
                if folowers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: folowers)
                if self.followers.isEmpty {
                    let message = "This User does not have any follower, please someone follow them "
                    
                    DispatchQueue.main.async{
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                    return
                }
                if self.page == 1 {
                    DispatchQueue.main.async {
                        self.configureSearchController()
                    }
                }
                
                DispatchQueue.main.async {
                    self.updateData(on: self.followers)
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: {( collectionView, indexPath, follower) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on follower: [Follower]){
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(follower)
        DispatchQueue.main.async(){
            self.dataSource.apply(snapShot, animatingDifferences: true)
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contenHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contenHeight-height {
            guard hasMoreFollowers else { return }
            page+=1
            getFollowers(username: username, page: page)
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollower:followers
        let followerr = activeArray[indexPath.item]
        DispatchQueue.main.async {
            let destVC = UserInfoVC()
            destVC.username = followerr.login
            destVC.delegate = self
            self.navigationController?.pushViewController(destVC, animated: true)
        }

    }
}
extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: followers)
            return
        }
        isSearching = true
        filteredFollower = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollower)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}

extension FollowerListVC:FollowerListVCDelegate{
    func didRequestFollower(for username: String) {
//        self.username = username
//        title = username
//        page = 1
//        followers.removeAll()
//        filteredFollower.removeAll()
//        collectionView.setContentOffset(.zero, animated: true)
//        getFollowers(username: username, page: page)
    }
    
    
}
