//
//  TabBarController.swift
//  News App
//
//  Created by Mark Altshuler on 11/11/23.
//

import UIKit

class TabBarController: UITabBarController {

    @IBOutlet weak var logout: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogoutButton()
    }

    func setupLogoutButton() {
        logout.target = self
        logout.action = #selector(logoutButtonPressed)
    }

    @objc func logoutButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let loginNavigationController = storyboard.instantiateViewController(withIdentifier: "LoginNavigationController") as? UINavigationController,
               let loginViewController = loginNavigationController.topViewController as? LoginViewController {
                if let keyWindow = UIApplication.shared.windows.first {
                    keyWindow.rootViewController = loginNavigationController
                    keyWindow.makeKeyAndVisible()
                }
            }
    }
}
