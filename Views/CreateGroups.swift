//
//  CreateGroups.swift
//  hisab
//
//  Created by Nathan Nunes on 1/18/24.
//

import SwiftUI

struct CreateGroupView: View {
    @StateObject private var viewModel = CreateGroupViewModel()
    @Binding var groups: [Group]

    var body: some View {
        Form {
            Section(header: Text("Create Group")) {
                TextField("Group Name", text: $viewModel.groupName)
            }
            Section(header: Text("Add Expense")) {
                TextField("Amount", text: $viewModel.expenseAmount)
                TextField("Description", text: $viewModel.expenseDescription)
            }
            Section {
                Button("Add Expense") {
                    let newGroup = viewModel.createGroup()
                    groups.append(newGroup)
                }
            }
        }
        .navigationBarTitle("Create Group")
    }
}
struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy array of groups for the preview
        let dummyGroups: [Group] = [
            Group(id: UUID(), name: "Sample Group", expenses: [])
            // Add more sample groups if needed
        ]

        // Use a State variable to provide a Binding to the array of groups
        @State var previewGroups: [Group] = dummyGroups

        // Use the CreateGroupView with the provided Binding to the groups array
        return CreateGroupView(groups: $previewGroups)
    }
}
