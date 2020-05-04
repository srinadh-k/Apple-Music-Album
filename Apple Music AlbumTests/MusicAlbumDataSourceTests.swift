//
//  MusicAlbumViewModelDataSourceTests.swift
//  Apple Music AlbumTests
//
//  Created by Srinadh on 5/3/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//

import XCTest
@testable import Apple_Music_Album

class MusicAlbumDataSourceTests: XCTestCase {
    
    var dataSource : MusicAlbumDataSource!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        dataSource = MusicAlbumDataSource()
    }
    
    override func tearDownWithError() throws {
        dataSource = nil
        try super.tearDownWithError()
        
    }
    
    func testEmptyValueInDataSource() {
        
        dataSource.albumList.value = []
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")
    }
    
    func testValueInDataSource() {
        
        let album1 = Album(artworkUrl: "https://is5-ssl.mzstatic.com/image/thumb/Music113/v4/7f/0e/4c/7f0e4cf8-900b-f9ab-ce1e-778b35b5cb58/20UMGIM22022.rgb.jpg/200x200bb.png", name: "Kiss 5", artistName: "K CAMP", releaseDate: "2020-04-24", copyright: "An Interscope Records/Rare Sound Release; ℗ 2020 Interscope Records", genres: nil, artistUrl: nil)
      
        let album2 = Album(artworkUrl: nil, name: "Kiss 5", artistName: nil, releaseDate: "2020-04-24", copyright: "An Interscope Records/Rare Sound Release; ℗ 2020 Interscope Records", genres: nil, artistUrl: nil)
             
        
        dataSource.albumList.value = [album1, album2]
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        
        // expected two cells
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")
    }
    
    func testValueCell() {
        
        let album1 = Album(artworkUrl: "https://is5-ssl.mzstatic.com/image/thumb/Music113/v4/7f/0e/4c/7f0e4cf8-900b-f9ab-ce1e-778b35b5cb58/20UMGIM22022.rgb.jpg/200x200bb.png", name: "Kiss 5", artistName: "K CAMP", releaseDate: "2020-04-24", copyright: "An Interscope Records/Rare Sound Release; ℗ 2020 Interscope Records", genres: nil, artistUrl: nil)
        
        dataSource.albumList.value = [album1]
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.kAlubmCell)
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        guard let _ = dataSource.tableView(tableView, cellForRowAt: indexPath) as? AlbumTableViewCell else {
            XCTAssert(false, "Expected Album Cell class")
            return
        }
    }
}
