//
//  DetailViewController.swift
//  lab-tunley
//
//  Created by Charlie Hieger on 12/5/22.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {

    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!

    @IBOutlet weak var artistLabel: UILabel!

    var track: Track!

    override func viewDidLoad() {
        super.viewDidLoad()
        trackNameLabel.text = track.title
        artistLabel.text = track.description
        let url = track.urlToImage;
        if let imageUrl = URL(string: url ?? "https://media.istockphoto.com/id/1354776457/vector/default-image-icon-vector-missing-picture-page-for-website-design-or-mobile-app-no-photo.jpg?s=612x612&w=0&k=20&c=w3OW0wX3LyiFRuDHo9A32Q0IUMtD4yjXEvQlqyYk9O4=") {
            Nuke.loadImage(with: ImageRequest(url: imageUrl), into: trackImageView) { response, _, error in
                if error != nil {
                    print("Image loading error: \(error)")
                }
            }
        } else {
            print("Invalid URL")
        }
    }
}
