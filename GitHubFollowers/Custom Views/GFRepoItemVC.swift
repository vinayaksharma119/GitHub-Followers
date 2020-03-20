//
//  GFRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Vinayak Sharma on 14/03/20.
//  Copyright © 2020 Vinayak Sharma. All rights reserved.
//

import UIKit

class GFRepoItemVC : GFItemInfoVC{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
