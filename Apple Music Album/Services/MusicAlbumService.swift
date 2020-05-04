//
//  MusicAlbumsVC.swift
//  Apple Music Album
//
//  Created by Srinadh on 5/2/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//

import Foundation

protocol MusicAlbumServiceProtocol : class {
    func fetchTopMusicAlbums(_ completion: @escaping ((Result<MusicAlbumModel, ErrorResult>) -> Void))
}

final class MusicAlbumService : RequestHandler, MusicAlbumServiceProtocol {
    static let shared = MusicAlbumService()
    
    var task : URLSessionTask?
    
    func fetchTopMusicAlbums(_ completion: @escaping ((Result<MusicAlbumModel, ErrorResult>) -> Void)) {
        
        self.cancelFetchTopMusicAlbums()
        
        task = RequestService().loadData(urlString: URLs.topAlbums, completion: self.networkResult(decodingType: MusicAlbumModel.self , completion: completion))
    
    }
    
    func cancelFetchTopMusicAlbums() {
        
        if let task = task {
    
            task.cancel()
        
        }
        
        task = nil
    }
}
