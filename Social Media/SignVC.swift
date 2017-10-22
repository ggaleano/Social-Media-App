//
//  ViewController.swift
//  Social Media
//
//  Created by Geovanny Galeano on 10/5/17.
//  Copyright © 2017 Geovanny Galeano. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInVC.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        //let credential = FIRFacebookAuthProvider.credential(withAccessToken: (FBSDKAcessO)
    }

    func firebaseAuth(_credential: AuthCredential){
        Auth.auth().signIn(with: _credential, completion: { (user, error) in
            if error != nil {
                print("Geo: @@Unable to authenticate wth Firebase - \(error)")
            } else {
                print("Geo: @@Successfully authenticated with Firebase")
                if let user = user {
                    let userData = ["provider": _credential.provider]
                    self.completeSignIn(id: user.uid, userData: userData)
                }
            }
            
        })
    }
    
    
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let pwd = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("Geo: Email user authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)

                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("Geo: Unable to authe with Firebase")
                        } else {
                            print("Geo: Succesfully authenticated with Firebase")
                            if let user = user {
                                let userData = ["provider": user.providerID]

                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keyChainResult =  KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Geo: Data saved to keychain \(keyChainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }

}










