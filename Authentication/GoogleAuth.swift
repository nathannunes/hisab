//
//  GoogleAuth.swift
//  hisab
//
//  Created by Nathan Nunes on 1/30/24.
//

import Foundation
import Firebase
import GoogleSignIn
import UIKit // Import UIKit to use UIViewController



func googleSignIn(presentingViewController: UIViewController, completion: @escaping (Bool) -> Void) {
    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = config
    
    GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
          guard error == nil else {
            // [START_EXCLUDE]
              presentingViewController.displayError(error, from: "Google Sign-In")
              completion(false)
              return
            // [END_EXCLUDE]
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            // [START_EXCLUDE]
            let error = NSError(
              domain: "GIDSignInError",
              code: -1,
              userInfo: [
                NSLocalizedDescriptionKey: "Unexpected sign in result: required authentication data is missing.",
              ]
            )
              presentingViewController.displayError(error, from: "Google Sign-In")
              completion(false)
              return
            // [END_EXCLUDE]
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

          // [START_EXCLUDE]
          signIn(with: credential)
          saveUserToFirebase(completion: completion)
          // [END_EXCLUDE]
        }
        // [END headless_google_auth]
      }
    
func signIn(with credential: AuthCredential, authViewModel) {
    // [START signin_google_credential]
    Auth.auth().signIn(with: credential) { result, error in
      // [START_EXCLUDE silent]
      guard error == nil else { 
          return }
      // [END_EXCLUDE]

      // At this point, our user is signed in
      // [START_EXCLUDE silent]
      // so we advance to the User View Controller
      AuthViewModel()
      // [END_EXCLUDE]
    }
    // [END signin_google_credential]
  }

/*
GIDSignIn.sharedInstance.signIn(with: config, presenting: presentingViewController) { user, error in
    if let error = error {
        print("Sign in error: \(error)")
        completion(false)
        return
    }

    guard let authentication = user?.authentication, let idToken = authentication.idToken else {
        completion(false)
        return
    }
    let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

    Auth.auth().signIn(with: credential) { authResult, error in
        if error != nil {
            completion(false)
            return
        }
        saveUserToFirebase(completion: completion)
    }
} */
