//
//  GFRepoItemVC.swift
//  GHFollowers
//

import Foundation

class GFRepoItemVC : GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    private func configureItem() {
        itemInfoViewOne.set(iteminfo: .repos,withCnt: userr.publicRepos)
        itemInfoViewTwo.set(iteminfo: .gists, withCnt: userr.publicGists)
        
        actionBtn.set(bgColor: .systemPurple, title: "Github Profile")
    }
    override func actionBtnTyped(){
        delegate.didTapGitProfile(for: userr)
    }
}
