//
//  MusicAlbumService.swift
//  Apple Music AlbumTests
//
//  Created by Srinadh on 5/3/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//

import XCTest
@testable import Apple_Music_Album

class MusicAlbumServiceTests: XCTestCase {

    func testCancelRequest() {
        
        MusicAlbumService.shared.fetchTopMusicAlbums{ (_) in
            // ignore call
        }
        MusicAlbumService.shared.cancelFetchTopMusicAlbums()
        XCTAssertNil(MusicAlbumService.shared.task, "Expected task nil")
    }

}
