//
//  File.swift
//  Makestagram
//
//  Created by Mari Campbell on 7/12/18.
//  Copyright © 2018 Make School. All rights reserved.
//

// import Foundation
//All code from before^

//
//  ViewController.swift
//  Makestagram
//
//  Created by Mari Campbell on 7/12/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    //MARK: Properties
    
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
 /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 */
    //MARK: IBActions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        //1
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        //2
        authUI.delegate = self
        
        //3
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in:\(error.localizedDescription)")
            return
        }
        //1
        guard let user = authDataResult?.user
            else { return }
        
        //2
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        //3
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            //1
            if let userDict = snapshot.value as? [String: Any] {
                print("User already exists \(userDict.debugDescription).")
            } else {
                print("New user!")
            }
    })
}

}

