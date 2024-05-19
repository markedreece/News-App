//
//  NewsViewController.swift
//  Group 25
//  Final Project
//
//  Created by Mark Altshuler, Sunwoo Lee, Mark Reece, and Brandon Rojas on Fall 2023.
//

import UIKit
import RealmSwift

class TracksViewController: UIViewController, UITableViewDataSource {

    var tracks: [Track] = []
    
    var notificationToken: NotificationToken?
    
    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
            super.viewDidLoad()

            fetchData()
        

            notificationToken = RealmAppManager.shared.currentUser?.selectedNewsOutlets.observe { [weak self] changes in
                switch changes {
                case .initial, .update:
                    self?.reloadTracks()
                case .error(let error):
                    print("Error observing selectedNewsOutlets changes: \(error.localizedDescription)")
                }
            }
        }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)

           fetchData()

        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func fetchData() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=abc-news,associated-press,bbc-news,cnn,espn,fox-news,ign,national-geographic,nbc-news,the-washington-post&pageSize=100&apiKey=62355d78511e432a8de6c7f84ebe841e")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }
            
            guard let data = data else {
                print("❌ Data is nil")
                return
            }
            
            let decoder = JSONDecoder()
            _ = DateFormatter()
            let dateFormats = ["yyyy-MM-dd'T'HH:mm:ssZ", "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"]

            decoder.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)

                let formatter = DateFormatter()
                for format in dateFormats {
                    formatter.dateFormat = format
                    if let date = formatter.date(from: dateString) {
                        return date
                    }
                }

                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
            }
            
            do {
                let response = try decoder.decode(TracksResponse.self, from: data)
                print(response.articles)
                
                DispatchQueue.main.async {
                let currentUser = RealmAppManager.shared.currentUser
                let selectedNewsOutlets = currentUser?.selectedNewsOutlets
                var tracks: [Track] = []

                if let selectedNewsOutlets = selectedNewsOutlets {
                    for newsOutlet in selectedNewsOutlets {
                        print("News Outlet: \(newsOutlet)")

                        let filteredArticles = response.articles.filter { article in
                            return article.source.id == newsOutlet
                        }

                        tracks += filteredArticles
                    }
                }
                    self?.tracks = tracks
                    self?.tableView.reloadData()
                }
            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
        }

        // Initiate the network request
        task.resume()
        tableView.dataSource = self
           
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
    }
    private func reloadTracks() {
           // Reload the table view on the main thread
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
       }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // TODO: Pt 1 - Pass the selected track to the detail view controller

            // Get the cell that triggered the segue
            if let cell = sender as? UITableViewCell,
               // Get the index path of the cell from the table view
               let indexPath = tableView.indexPath(for: cell),
               // Get the detail view controller
               let detailViewController = segue.destination as? DetailViewController {

                // Use the index path to get the associated track
                let track = tracks[indexPath.row]

                // Set the track on the detail view controller
                detailViewController.track = track
            }
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tracks.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            // Get a cell with identifier, "TrackCell"
            // the `dequeueReusableCell(withIdentifier:)` method just returns a generic UITableViewCell so it's necessary to cast it to our specific custom cell.
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell

            // Get the track that corresponds to the table view row
            let track = tracks[indexPath.row]

            // Configure the cell with it's associated track
            cell.configure(with: track)

            // return the cell for display in the table view
            return cell
        }
    deinit {
            notificationToken?.invalidate()
        }
}
