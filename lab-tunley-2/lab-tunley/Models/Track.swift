//
//  Track.swift
//  lab-tunley
//
//  Created by Charlie Hieger on 12/2/22.
//

import Foundation

// TODO: Pt 1 - Create a Track model struct

struct TracksResponse: Decodable {
    let articles: [Track]
    let totalResults: Int?
}

struct Track: Decodable {
    let source: TrackID
    let title: String?
    let publishedAt: Date

    // Detail properties
    var author: String?
    var content: String?
    let description: String?
    var urlToImage: String?
    let url: URL?
}

struct TrackID: Decodable {
    let id: String?
    let name: String?
}
