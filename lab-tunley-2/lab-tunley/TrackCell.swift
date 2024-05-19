//
//  TrackCell.swift
//  lab-tunley
//
//  Created by Charlie Hieger on 12/3/22.
//

import UIKit
import Nuke

class TrackCell: UITableViewCell {


    
    @IBOutlet weak var trackImageView: UIImageView!
    
    @IBOutlet weak var trackNameLabel: UILabel!
    
    @IBOutlet weak var artistNameLabel: UILabel!

    @IBOutlet weak var publishedDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /// Configures the cell's UI for the given track.
    func configure(with track: Track) {
        trackNameLabel.text = track.title
        artistNameLabel.text = track.source.name
//
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        publishedDateLabel.text = dateFormatter.string(from: track.publishedAt)
//
//         Load image async via Nuke library image loading helper method
//        Nuke.loadImage(with: track.artworkUrl100, into: trackImageView)
        var url = URL(string: track.urlToImage!);
        if url == nil {
            url = URL(string: "https://media.istockphoto.com/id/1354776457/vector/default-image-icon-vector-missing-picture-page-for-website-design-or-mobile-app-no-photo.jpg?s=612x612&w=0&k=20&c=w3OW0wX3LyiFRuDHo9A32Q0IUMtD4yjXEvQlqyYk9O4=")
        }
        Nuke.loadImage(with: url!, into: trackImageView)
    }

}
