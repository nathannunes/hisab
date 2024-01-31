//
//  GroupsViewModel.swift
//  hisab
//
//  Created by Nathan Nunes on 1/30/24.
//

import SwiftUI
import FirebaseDatabase
import FirebaseFirestore

class GroupsViewModel: ObservableObject {
    @Published var groups: [Group] = []

    init() {
        fetchGroups()
    }

    func fetchGroups() {
        let db = Firestore.firestore()
        db.collection("groups").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var newGroups: [Group] = []
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    if let group = Group(document: document) {
                        newGroups.append(group)
                    }
                }
                DispatchQueue.main.async {
                    self.groups = newGroups
                }
            }
        }
    }
}



