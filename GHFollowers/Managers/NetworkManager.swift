//
//  NetworkManager.swift
//  GHFollowers
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage> ()
    
    private init () {}
    
    func getFollowers( for username : String, page : Int, completed : @escaping ( Result<[ Follower], GFError>) -> Void){
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invaliedUsername) )
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let folowers = try decoder.decode([Follower].self, from: data)
                completed(.success(folowers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
        
    }
    
    func getUserInfo( for username : String, completed : @escaping ( Result<User, GFError>) -> Void){
        let endPoint = baseURL + "\(username)"
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invaliedUsername) )
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func downloadImage( from urlString : String, completed : @escaping(UIImage?)-> Void){
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                completed(nil)
                return
            }
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200  else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
           completed(image)
        }
        task.resume()
    }
}
