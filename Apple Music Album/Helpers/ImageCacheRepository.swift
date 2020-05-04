//
//  MusicAlbumsVC.swift
//  Apple Music Album
//
//  Created by Srinadh on 5/2/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//

import UIKit

class ImageCacheRepository {
    
    public static let shared: ImageCacheRepository = ImageCacheRepository()
    
    private var cachedAvatars: [String: Data] = [:]
    
    public func loadImage(url: String, completionHandler: @escaping (Data?)->Void) {
        if let imageData = self.cachedAvatars[url] {
            completionHandler(imageData)
        }
        else {
             self.downloadImage(url: url) { data in
                completionHandler(data)
            }
        }
    }
    
    private func downloadImage(url: String, completionHandler: @escaping (Data?)->Void) {
        _ = RequestService().loadData(urlString: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    self?.cachedAvatars[url] = data
                
                    completionHandler(data)
                
                case .failure( _) :
                    
                    completionHandler(nil)
                }
            }
        }
    }
    
}
