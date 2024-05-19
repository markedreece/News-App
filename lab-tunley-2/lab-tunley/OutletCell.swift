//
//  TrackCell.swift
//  lab-tunley
//
//  Created by Charlie Hieger on 12/3/22.
//

import UIKit
import Nuke
import RealmSwift

class OutletCell: UITableViewCell {

    @IBOutlet weak var outletImageView: UIImageView!

    @IBOutlet weak var outletNameLabel: UILabel!
    
    @IBOutlet weak var outletFollowButton: UIButton!
    
    var outlets: [Outlet] = []
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        outlets = Outlet.mockOutlets
    }
    

        @IBAction func followButtonTapped(_ sender: UIButton) {
            if let outletName = outletNameLabel.text {
                if let outlet = findOutlet(forOutletName: outletName) {
                    let outletId = outlet.outletId
                
                
                let isSubscribed = isOutletSubscribed(outletId: outletId)
                
                guard let realm = try? Realm() else {
                    return
                }
                
                do {
                    try realm.write {
                        if isSubscribed {
                            if let currentUser = RealmAppManager.shared.currentUser,
                               let index = currentUser.selectedNewsOutlets.firstIndex(of: outletId) {
                                currentUser.selectedNewsOutlets.remove(at: index)
                            }
                            
                        } else {
                            if let currentUser = RealmAppManager.shared.currentUser {
                                currentUser.selectedNewsOutlets.append(outletId)
                            }
                        }
                    }
                } catch {
                    print("Error performing write transaction: \(error.localizedDescription)")
                }
                
                updateUIForSubscriptionState(isSubscribed: !isSubscribed)
                } else {
                    print("❌ Outlet not found")
                }
            }
        }
    
    private func findOutlet(forOutletName outletName: String) -> Outlet? {
        if let outlet = outlets.first(where: {$0.outletName == outletName}) {
            return outlet
        } else{
            return nil
        }
    }

        private func isOutletSubscribed(outletId: String) -> Bool {
            if let currentUser = RealmAppManager.shared.currentUser {
                return currentUser.selectedNewsOutlets.contains(outletId)
            }
            return false
        }

        private func updateUIForSubscriptionState(isSubscribed: Bool) {
            if isSubscribed {
                outletFollowButton.setTitle("Unfollow", for: .normal)
                outletFollowButton.tintColor = .gray
            } else {
                   outletFollowButton.setTitle("Follow", for: .normal)
                   outletFollowButton.tintColor = .systemBlue
               }

               outletFollowButton.layoutIfNeeded()
            
        }

    func configure(with outlet: Outlet) {
            outletNameLabel.text = outlet.outletName
            updateUIForSubscriptionState(isSubscribed: isOutletSubscribed(outletId: outlet.outletId))
            Nuke.loadImage(with: outlet.artworkUrl100, into: outletImageView)
        }
}


