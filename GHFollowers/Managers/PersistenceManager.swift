//
//  PersistenceManager.swift
//  GHFollowers
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    enum keys {
        static let favs = "favourites"
    }
    static func updateWith(favorite : Follower, actionType : PersistenceActionType, completed : @escaping(GFError?)-> Void){
        
        retriveFavourites { result in
            switch result {
            case .success(var favo):
                switch actionType {
                    
                case .add :
                    guard !favo.contains(favorite) else{
                        completed(.alreadyINFavs)
                        return
                    }
                    favo.append(favorite)
                    
                case .remove:
                    favo.removeAll{ $0.login == favorite.login }
                }
                completed(save(favouries: favo))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retriveFavourites(completed : @escaping(Result <[Follower], GFError>) -> Void) {
        guard let favouriteData  = defaults.object(forKey: keys.favs) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favourite = try decoder.decode([Follower].self, from: favouriteData)
            completed(.success(favourite))
        } catch {
            completed(.failure(.invalidData))
        }
    }
    static func save(favouries: [Follower]) -> GFError?{
        do {
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(favouries)
            defaults.set(encodedFavourites,forKey: keys.favs)
        } catch {
            return .unableFavs
            
        }
        return nil
    }
}
