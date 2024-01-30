//
//  AuthModel.swift
//  hisab
//
//  Created by Nathan Nunes on 1/30/24.
//

import Foundation
import FirebaseAuth
import UIKit

class AuthViewModel: ObservableObject {
    @Published var isUserAuthenticated: Bool = false

    init() {
        isUserAuthenticated = Auth.auth().currentUser != nil
    }

    func signIn(presentingViewController: UIViewController) {
        googleSignIn(presentingViewController: presentingViewController) { success in
            DispatchQueue.main.async {
                self.isUserAuthenticated = success
            }
        }
    }
}

