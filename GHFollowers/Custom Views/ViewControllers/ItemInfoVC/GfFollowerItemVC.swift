//
//  GFRepoItemVC.swift
//  GHFollowers
//


import Foundation

class GfFollowerItemVC : GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem() {
        itemInfoViewOne.set(iteminfo: .folowers,withCnt: userr.followers)
        itemInfoViewTwo.set(iteminfo: .following, withCnt: userr.following)
        actionBtn.set(bgColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionBtnTyped() {
        delegate.didTapGetFolowers(for: userr)
    }
}
