//
//  MusicAlbumsVC.swift
//  Apple Music Album
//
//  Created by Srinadh on 5/2/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//

import Foundation
import UIKit

struct MusicAlbumModel: Decodable {
    let feed: AlbumResult?
}
struct AlbumResult: Decodable {
    let results: [Album]?
}
struct Album: Decodable {
    let artworkUrl: String?
    let name: String?
    let artistName: String?
    let releaseDate: String?
    let copyright: String?
    let genres: [GenresResult]?
    let artistUrl: String?
    enum CodingKeys: String, CodingKey {
        case artworkUrl = "artworkUrl100"
        case name
        case artistName
        case releaseDate
        case copyright
        case genres
        case artistUrl
    }
}
struct GenresResult: Decodable {
    let name: String?
}
