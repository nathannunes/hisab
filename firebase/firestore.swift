//
//  firestore.swift
//  hisab
//
//  Created by Nathan Nunes on 1/30/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

func saveGroupToFirebase(group: Group, completion: @escaping (Bool) -> Void) {
    let db = Firestore.firestore()
    db.collection("groups").addDocument(data: group.dictionary) { error in
        if let error = error {
            print("Error adding document: \(error)")
            completion(false)
        } else {
            // If you want to handle the document ID, do it here. For now, it's just being printed.
            print("Document added successfully")
            completion(true)
        }
    }
}

func saveUserToFirebase(completion: @escaping (Bool) -> Void) {
    guard let user = Auth.auth().currentUser else {
        // No user is signed in
        completion(false)
        return
    }

    let db = Firestore.firestore()
    let userRef = db.collection("users").document(user.uid)

    userRef.getDocument { (document, error) in
        if let document = document, document.exists {
            // User already exists in Firestore
            // Handle accordingly, perhaps update data or just proceed
            completion(true)
        } else {
            // User does not exist, save new data
            saveUserData(user, in: db) { success in
                completion(success)
            }
        }
    }
}


func saveUserData(_ user: User, in db: Firestore, completion: @escaping (Bool) -> Void) {
    db.collection("users").document(user.uid).setData([
        "name": user.displayName ?? "",
        "email": user.email ?? "",
        // Add other user details you need
    ]) { error in
        if let error = error {
            // Log the error or handle it as necessary
            print("Error saving user data: \(error.localizedDescription)")
            completion(false)
        } else {
            // Data saved successfully
            completion(true)
        }
    }
}

