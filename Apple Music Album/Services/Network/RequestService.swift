//
//  MusicAlbumsVC.swift
//  Apple Music Album
//
//  Created by Srinadh on 5/2/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//

import Foundation

final class RequestService {
    
    func loadData(urlString: String, session: URLSession = URLSession(configuration: .default), completion: @escaping (Result<Data, ErrorResult>) -> Void) -> URLSessionTask? {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.network(string: Constants.Messages.kInvalidUrlFormat)))
            return nil
        }
        
        var request = RequestFactory.request(method: .GET, url: url)
        
        if !Reachability().isConnectedToNetwork() {
            request.cachePolicy = .returnCacheDataDontLoad
            completion(.failure(.network(string: Constants.Messages.kInternetNotAvailable)))
            return nil
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completion(.failure(.network(string: Constants.Messages.kSomethingWentWrong)))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
        return task
    }
}
