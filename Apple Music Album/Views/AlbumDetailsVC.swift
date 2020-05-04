//
//  AlbumDetailsVC.swift
//  Apple Music Album
//
//  Created by Srinadh on 5/2/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//

import UIKit

class AlbumDetailsVC: UIViewController {
    
    var albumData:Album?
    
    private var datasource : AlbumDetailsDataSource?
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .blue
        guard let albumData = albumData else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        datasource = AlbumDetailsDataSource(detailVC: self, albumData: albumData)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Constants.ConstantValues.kAlbumDetails
        datasource?.loadAlbumDetails()
        appicationHandlers()
    }
    private func appicationHandlers(){
        datasource?.redirectToMusicAlbum = { url in
                UIApplication.shared.open(url, options: [:])
        }
        datasource?.onErrorHandling = {err in
            self.showAlert(message: err)
        }
    }
    
    
}
