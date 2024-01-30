//
//  LoginView.swift
//  hisab
//
//  Created by Nathan Nunes on 1/30/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @Environment(\.rootViewController) var rootViewController

    var body: some View {
        VStack {
            Button("Sign in with Google") {
                if let currentVC = rootViewController {
                    authViewModel.signIn(presentingViewController: currentVC)
                }
            }
        }
    }
}


struct RootViewControllerKey: EnvironmentKey {
    static let defaultValue: UIViewController? = nil
}

extension EnvironmentValues {
    var rootViewController: UIViewController? {
        get { self[RootViewControllerKey.self] }
        set { self[RootViewControllerKey.self] = newValue }
    }
}

struct RootViewControllerModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .environment(\.rootViewController, UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }?.rootViewController)
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy instance of AuthViewModel for the preview
        let authViewModel = AuthViewModel()

        // Use the LoginView with the provided dummy instance of AuthViewModel
        LoginView(authViewModel: authViewModel)
    }
}
