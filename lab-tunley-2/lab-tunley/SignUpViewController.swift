//
//  SignUpViewController.swift
//  lab-insta-parse
//
//  Created by Charlie Hieger on 11/1/22.
//

import UIKit

import RealmSwift

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onSignUpTapped(_ sender: Any) {
        Task { @MainActor in
            guard let username = usernameField.text,
                  let email = emailField.text,
                  let password = passwordField.text,
                  !username.isEmpty,
                  !email.isEmpty,
                  !password.isEmpty else {
                showMissingFieldsAlert()
                return
            }
            

            let userCredentials = Credentials.emailPassword(email: email, password: password)
            let client = RealmAppManager.shared.app?.emailPasswordAuth
            do {
                // Register user
                try await client?.registerUser(email: email, password: password)

                // Create a new AppUser with the email as the _id
                let newUser = AppUser()
                newUser._id = email
                newUser.selectedNewsOutlets = List<String>()

                // Get the Realm app
                if let app = RealmAppManager.shared.app {
                    do {
                        let realm = try await Realm()
                        
                        try realm.write {
                            realm.add(newUser)
                        }

                        print("User added to Realm successfully.")
                        showAlert(description: "account created", status: true)
                        
                    } catch {
                        print("Error creating Realm instance or writing user to Realm: \(error.localizedDescription)")
                    }
                        print("User added to Realm successfully.")
                        showAlert(description: "account created", status: true)
                    do {
                        let realm = try await Realm()

                        let results = realm.objects(AppUser.self)

                        for user in results {
                            print("User ID: \(user._id ?? "N/A")")
                            print("Selected News Outlets: \(user.selectedNewsOutlets)")
                            print("------------------------------")
                        }
                        } catch {
                        print("Error creating Realm instance or writing/reading user to/from Realm: \(error.localizedDescription)")
                        showAlert(description: error.localizedDescription, status: false)
                    }
                } else {
                    print("Realm app is nil.")
                }
            } catch {
                print("Error registering user: \(error.localizedDescription)")
                showAlert(description: error.localizedDescription, status: false)
            }
        }
    }
    
    private func showAlert(description: String?, status: Bool) {
        var signUpStatusTitle = ""
        if(status) {
            signUpStatusTitle = "Success"
        } else {
            signUpStatusTitle = "Unable to Sign Up"
        }
        let alertController = UIAlertController(title: signUpStatusTitle, message: description, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Opps...", message: "We need all fields filled out in order to sign you up.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
