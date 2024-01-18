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
        let newGroup = Group(id: UUID(), name: groupName, expenses: [Expense(amount: Double(expenseAmount) ?? 0, description: expenseDescription)], personIDs: personIDs)
        return newGroup
    }
}


