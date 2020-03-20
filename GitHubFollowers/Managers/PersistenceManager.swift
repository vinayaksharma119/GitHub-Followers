//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by Vinayak Sharma on 17/03/20.
//  Copyright © 2020 Vinayak Sharma. All rights reserved.
//

import Foundation

enum PersistenceActionType{
    case add, remove
}

enum PersistenceManager{
    
    static private let defaults = UserDefaults.standard
    
    enum keys{
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?)-> Void){

        retrieveFavorites { result in
            switch result{
            case .success(let favorites):
                var retrivedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrivedFavorites.contains(favorite) else {
                        completed (.alreadyInFavorites)
                        return
                    }
                    retrivedFavorites.append(favorite)
                case .remove:
                    retrivedFavorites.removeAll {$0.login == favorite.login}
                }
                
                completed(saveFavorites(favorites: retrivedFavorites))
                
                
            case .failure(let error):
                completed(error)
            }
        }
        
    }
    
    
    static func retrieveFavorites(completed : @escaping(Result<[Follower], GFError>) -> Void){
        
        guard let favoritesData = defaults.object(forKey: keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorites))
        }
    }
    
    static func saveFavorites(favorites: [Follower])-> GFError?{
        
        do{
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: keys.favorites)
            return nil
        } catch {
            return .unableToFavorites
        }
    }
}
