//
//  User.swift
//  GitHubFollowers
//
//  Created by Vinayak Sharma on 26/02/20.
//  Copyright © 2020 Vinayak Sharma. All rights reserved.
//

import UIKit

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
