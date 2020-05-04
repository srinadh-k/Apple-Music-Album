//
//  MusicAlbumsVC.swift
//  Apple Music Album
//
//  Created by Srinadh on 5/2/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//

import Foundation
import UIKit
class GenericDataSource<T> : NSObject {
    var albumList: DynamicValue<[T]> = DynamicValue([])
}
class MusicAlbumDataSource : GenericDataSource<Album> {
    var redirectToAlubmDetailPage: ((Album) -> Void)?

}
extension MusicAlbumDataSource : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumList.value.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.kAlubmCell, for: indexPath) as? AlbumTableViewCell
        if let cell = cell{
            cell.album = albumList.value[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
    
}
extension MusicAlbumDataSource : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albumList.value[indexPath.row]
        self.redirectToAlubmDetailPage?(album)
    }
    
}

