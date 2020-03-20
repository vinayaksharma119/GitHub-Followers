//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Vinayak Sharma on 14/03/20.
//  Copyright © 2020 Vinayak Sharma. All rights reserved.
//

import UIKit

class GFFollowerItemVC : GFItemInfoVC{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Git Followers")
    }
    
    override func actionButtonTapped() {
        guard user.followers != 0 else {presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers", buttonTitle: "Ok")
            return
        }
        delegate.didTapGitFollowers(for: user)
        dismiss(animated: true)
    }
}
