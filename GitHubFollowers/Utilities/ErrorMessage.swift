//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Vinayak Sharma on 02/03/20.
//  Copyright © 2020 Vinayak Sharma. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server"
    case invalidData = "Data received from the server is invalid"
    case unableToFavorites = "There was a error! Please try again"
    case alreadyInFavorites = "Already in favorites"
}
