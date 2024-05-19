//
//  Track.swift
//  lab-tunley
//
//  Created by Charlie Hieger on 12/2/22.
//

import Foundation

// TODO: Pt 1 - Create a Track model struct

struct Outlet {
    let outletName: String
    let outletId: String
    let artworkUrl100: URL
}

// TODO: Pt 1 - Create an extension with a mock tracks static var

extension Outlet {

    /// An array of mock tracks
    static var mockOutlets: [Outlet]  = [
        Outlet(outletName: "ABC News",
               outletId: "abc-news",
              artworkUrl100: URL(string: "https://dlgie0dznny76.cloudfront.net/wp-content/uploads/2018/02/13143430/abcnews-logo.jpg")!),
        Outlet(outletName: "Associated Press",
               outletId: "associated-press",
              artworkUrl100: URL(string: "https://colabnews.co/wp-content/uploads/2020/11/small.AP_Logo-square_RGB-Jim-Clarke.png")!),
        Outlet(outletName: "BBC News",
               outletId: "bbc-news",
              artworkUrl100: URL(string: "https://play-lh.googleusercontent.com/Alt_6SesU0dU3YlDEsPREYkEb2ZMN-K4PMdLtUKO6ts1UBrDUF8Sh6LzcDYHd03jfP7z")!),
        Outlet(outletName: "CNN",
               outletId: "cnn",
              artworkUrl100: URL(string:"https://obeygiant.com/images/2017/01/cnn-logo-square.png")!),
        Outlet(outletName: "ESPN",
               outletId: "espn",
              artworkUrl100: URL(string: "https://thumbs.dreamstime.com/b/logo-icon-vector-logos-icons-set-social-media-flat-banner-vectors-svg-eps-jpg-jpeg-paper-texture-glossy-emblem-wallpaper-210442610.jpg")!),
        Outlet(outletName: "Fox News",
               outletId: "fox-news",
              artworkUrl100: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Fox_News_Channel_logo.svg/512px-Fox_News_Channel_logo.svg.png")!),
        Outlet(outletName: "National Geographic",
               outletId: "national-geographic",
              artworkUrl100: URL(string: "https://footlooseindian.com/wp-content/uploads/nat-geo-squarelogo.jpg")!),
        Outlet(outletName: "NBC News",
               outletId: "nbc-news",
              artworkUrl100: URL(string: "https://media1.s-nbcnews.com/i/assets/nbc-news-color-square-dvt.png")!),
        Outlet(outletName: "The Washington Post",
               outletId: "the-washington-post",
              artworkUrl100: URL(string: "https://assets.stickpng.com/images/60915b7df9f20800044365bf.png")!),
        
    ]

    // We can now access this array of mock tracks anywhere like this:
    // let tracks = Tracks.mockTracks
}
