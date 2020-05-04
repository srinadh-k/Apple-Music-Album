//
//  MusicAlbumsVC.swift
//  Apple Music Album
//
//  Created by Srinadh on 5/2/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//


import Foundation

struct MusicAlbumViewModel {
    
    weak var dataSource : GenericDataSource<Album>?
    weak var service: MusicAlbumServiceProtocol?
    
    var onErrorHandling : ((ErrorResult) -> Void)?
    
    init(service: MusicAlbumServiceProtocol = MusicAlbumService.shared, dataSource : GenericDataSource<Album>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func loadTopMusicAlumbs() {
        
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        service.fetchTopMusicAlbums {  result in
            DispatchQueue.main.async {
                switch result {
                case .success(let musicAlbum) :
                    
                    if let alubms = musicAlbum.feed?.results{
                        self.dataSource?.albumList.value = alubms
                    }
                    
                case .failure(let error) :
                    self.onErrorHandling?(error)
                }
            }
        }
        
    }
}
