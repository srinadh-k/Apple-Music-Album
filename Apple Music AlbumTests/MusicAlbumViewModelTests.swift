//
//  MusicAlbumViewModelTests.swift
//  Apple Music AlbumTests
//
//  Created by Srinadh on 5/3/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//

import XCTest
@testable import Apple_Music_Album

class MusicAlbumViewModelTests: XCTestCase {

    var viewModel : MusicAlbumViewModel!
    var dataSource : GenericDataSource<Album>!
    fileprivate var service : MockCurrencyService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.service = MockCurrencyService()
        self.dataSource = GenericDataSource<Album>()
        
        self.viewModel = MusicAlbumViewModel(service: service, dataSource: dataSource)
          
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
        self.dataSource = nil
        self.service = nil
        try super.tearDownWithError()
    }

    func testFetchMusicAlbums() {
        
        let expectation = XCTestExpectation(description: "Music Album fetch")
        
        service.musicAlbum = MusicAlbumModel(feed: AlbumResult(results: []))
        
        viewModel.onErrorHandling = { _ in
            XCTAssert(false, "ViewModel should not be able to fetch without service")
        }
        dataSource.albumList.addObserver(self) { _ in
                expectation.fulfill()
        }

        
        viewModel.loadTopMusicAlumbs()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchNoMusicAlbums() {
        
        let expectation = XCTestExpectation(description: "No Albums")
        
        service.musicAlbum = nil
        
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.loadTopMusicAlumbs()
        wait(for: [expectation], timeout: 5.0)
    }

}
fileprivate class MockCurrencyService : MusicAlbumServiceProtocol {
    
    var musicAlbum : MusicAlbumModel?

    func fetchTopMusicAlbums(_ completion: @escaping ((Result<MusicAlbumModel, ErrorResult>) -> Void)) {
       if let musicAlbum = musicAlbum {
            completion(Result.success(musicAlbum))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No Albums")))
        }
    }
}
