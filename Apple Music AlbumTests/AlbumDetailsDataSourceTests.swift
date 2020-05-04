//
//  AlbumDetailsDataSourceTests.swift
//  Apple Music AlbumTests
//
//  Created by Srinadh on 5/3/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//

import XCTest
@testable import Apple_Music_Album

class AlbumDetailsDataSourceTests: XCTestCase {
    
    var albumDetailVC : AlbumDetailsVC!
    var albumData : Album!
    var dataSource : AlbumDetailsDataSource!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        albumDetailVC = AlbumDetailsVC()
        
    }

    override func tearDownWithError() throws {
        
        albumDetailVC = nil
        
        albumData = nil 
         
        dataSource = nil
        
        try super.tearDownWithError()
    }

    func testAlbumWithNoData(){
        
        XCTAssertNil(albumDetailVC.albumData, "Expected task nil")
        
    }
    
    func testAlbumWithData(){
        
        let artistName = "K CAMP"
           albumData = Album(artworkUrl: "https://is5-ssl.mzstatic.com/image/thumb/Music113/v4/7f/0e/4c/7f0e4cf8-900b-f9ab-ce1e-778b35b5cb58/20UMGIM22022.rgb.jpg/200x200bb.png", name: "Kiss 5", artistName: artistName, releaseDate: "2020-04-24", copyright: "An Interscope Records/Rare Sound Release; ℗ 2020 Interscope Records", genres: nil, artistUrl: nil)
        
        dataSource = AlbumDetailsDataSource(detailVC: albumDetailVC, albumData: albumData)

        XCTAssertNil(dataSource.artistNameLbl.text, "Expected articstName Lbl contains nil")

        dataSource.loadAlbumDetails()
        
        XCTAssertNotNil(dataSource.artistNameLbl.text)
        
        XCTAssertEqual(dataSource.artistNameLbl.text, Constants.ConstantValues.kArtist + artistName)

       }

}
