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
    @Binding var isPresented: Bool

    @State private var personIDs: [String] = []
    @State private var isAddPeopleViewPresented = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Create Group")) {
                    TextField("Group Name", text: $viewModel.groupName)
                }
                Section(header: Text("Add People  (swipe left to delete)")) {
                    List {
                        ForEach(personIDs, id: \.self) { personID in
                            Text(personID)
                        }
                        .onDelete(perform: deletePerson)
                    }
                    Button("Add Person") {
                        isAddPeopleViewPresented = true
                    }
                    .sheet(isPresented: $isAddPeopleViewPresented) {
                        AddPeopleView(isPresented: $isAddPeopleViewPresented, personIDs: $personIDs)
                    }
                }
                Section {
                    Button("Save") {
                        viewModel.saveGroup(with: personIDs) { success in
                            if success {
                                // Dismiss the view and return to the home screen
                                isPresented = false
                            } else {
                                // Handle the error (e.g., show an alert)
                            }
                        }
                    }
                }

            }
            .navigationBarTitle("Create Group")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ContentView()) {
                        Text("Close")
                            .padding(9)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(50)
                            .onTapGesture {
                                // Discard changes and navigate to ContentView
                                   personIDs = [] // Clear the personIDs array
                                   isAddPeopleViewPresented = false // Dismiss the sheet if open
                                   // You might also want to reset any other relevant state variables or view model properties here
                                   // Set isPresented to false to dismiss the sheet
                                   isPresented = false
                            }
                    }
                }
            }

        }
    }

    private func deletePerson(at offsets: IndexSet) {
        personIDs.remove(atOffsets: offsets)
    }
}


struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy array of groups for the preview
        let dummyGroups: [Group] = [
            Group(id: UUID(), name: "Sample Group", personIDs: [])
            // Add more sample groups if needed
        ]

        // Use a State variable to provide a Binding to the array of groups
        @State var previewGroups: [Group] = dummyGroups

        // Use the CreateGroupView with the provided Binding to the groups array and a constant Binding for isPresented
        return CreateGroupView(groups: $previewGroups, isPresented: .constant(false))
    }
}

