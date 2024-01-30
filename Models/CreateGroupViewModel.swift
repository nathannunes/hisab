//
//  CreateGroupViewModel.swift
//  hisab
//
//  Created by Nathan Nunes on 1/18/24.
//

import SwiftUI

class CreateGroupViewModel: ObservableObject {
    @Published var groupName = ""
    @Published var expenseAmount = ""
    @Published var expenseDescription = ""
    @Published var personIDs: [String] = []

    func createGroup() -> Group {
        // Add logic to create the group using the groupName, expenses, and personIDs
        let newGroup = Group(id: UUID(), name: groupName, personIDs: personIDs)
        return newGroup
    }
    
    
    
    func saveGroup(with personIDs: [String], completion: @escaping (Bool) -> Void) {
        
            // Create a new group object with the converted amount
            let newGroup = Group(
                id: UUID(),
                name: self.groupName,
                personIDs: personIDs
            )

            // Call function to save group to Firebase
        saveGroupToFirebase(group: newGroup, completion: completion)
    }

    
    
}


