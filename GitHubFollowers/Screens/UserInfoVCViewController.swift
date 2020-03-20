//
//  UserInfoVCViewController.swift
//  GitHubFollowers
//
//  Created by Vinayak Sharma on 13/03/20.
//  Copyright © 2020 Vinayak Sharma. All rights reserved.
//

import UIKit
import SafariServices

protocol UserInfoVCViewControllerDelegate: class{
    func didTapGitHubProfile(for user: User)
    func didTapGitFollowers(for user: User)
}

class UserInfoVCViewController: UIViewController {

    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews : [UIView] = []
    
    
    var username : String!
    weak var delegate: FollowersListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        layoutUI()
        getUserInfo()
        
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo(){
        self.showSpinner()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
                   guard let self = self else {return}
                   self.removeSpinner()
                   
                   switch result{
                   case .success(let user):
                       DispatchQueue.main.async {self.configureUIElements(with: user)}
                       
                   case .failure(let error):
                       self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                   }
               }
    }
    
    func configureUIElements(with user: User){
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
    }
    
    func layoutUI() {
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews{
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: 20),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    

    @objc func dismissVC(){
        dismiss(animated: true)
    }

}

extension UserInfoVCViewController: UserInfoVCViewControllerDelegate{
    
    func didTapGitHubProfile(for user: User) {
        
        guard let url = URL(string: user.htmlUrl) else {presentGFAlertOnMainThread(title: "Inavlid URL", message: "URL attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC,animated: true)
    }
    
    func didTapGitFollowers(for user: User) {
        delegate.didRequestFollowers(for: user.login)
    }
    
   
    
    
    
}
