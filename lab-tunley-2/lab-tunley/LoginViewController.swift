//
//  LoginViewController.swift
//  lab-insta-parse
//
//  Created by Charlie Hieger on 10/29/22.
//
import UIKit
import RealmSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLoginTapped(_ sender: UIButton) {
        
        guard let email = emailField.text,
              let password = passwordField.text,
              !email.isEmpty,
              !password.isEmpty else {
            showMissingFieldsAlert()
            return
        }
        DispatchQueue.main.async {
            RealmAppManager.shared.app?.login(credentials: Credentials.emailPassword(email: email, password: password)) { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let user):
                        print("✅ Successfully logged in as user: \(user)")
                        
                        if let realm = try? Realm(),
                           let existingUser = realm.object(ofType: AppUser.self, forPrimaryKey: email) {
                            if existingUser.selectedNewsOutlets.isEmpty {
                                print("List of news outlets is empty. Initializing with an empty list.")
                                try? realm.write {
                                    existingUser.selectedNewsOutlets.removeAll()
                                    existingUser.selectedNewsOutlets.append(objectsIn: [])
                                }
                            }
                            RealmAppManager.shared.currentUser = existingUser
                        }
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let homeViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? UIViewController {
                            self.navigationController?.setViewControllers([homeViewController], animated: true)
                        }
                    case .failure(let error):
                        print("Login failed: \(error.localizedDescription)")
                        self.showAlert(description: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func showAlert(description: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            let alertController = UIAlertController(title: "Unable to Log in", message: description, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
    }
    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Oops...", message: "We need all fields filled out in order to log you in.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}


