//
//  ContentView.swift
//  hisab
//
//  Created by Nathan Nunes on 1/18/24.
//

import SwiftUI
import CoreData

import FirebaseDatabase

struct CustomHeaderView: View {
    var body: some View {
        Image("hisab_kitab") // Replace with the name of your image asset
            .resizable()
            .scaledToFit()
            .frame(height: 200)
    }
}

struct ContentView: View {
    @State private var isCreateGroupViewPresented = false
    @State private var groups: [Group] = []
    @StateObject private var viewModel = GroupsViewModel()
    
    var body: some View {
            NavigationView {
                List {
                    if viewModel.groups.isEmpty {
                        Text("Please add groups to continue")
                    } else {
                        ForEach(viewModel.groups, id: \.id) { group in
                            NavigationLink(destination: GroupDetailView(group: group)) {
                                Text(group.name)
                            }
                        }
                        .onDelete(perform: deleteGroup)
                    }
                }
                .navigationTitle("Groups")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if !viewModel.groups.isEmpty {
                            EditButton()
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Spacer();Spacer();Spacer();Spacer()
                            Spacer();Spacer();Spacer();Spacer();Spacer()
                            Image("hisab_kitab")
                                .resizable()
                                .frame(width: 200, height: 200)
                                .clipShape(Rectangle().offset(x: 10, y: 25).size(width: 160, height: 90))
                            Spacer()
                         }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add Group") {
                            isCreateGroupViewPresented = true
                        }
                    }
                }
                .sheet(isPresented: $isCreateGroupViewPresented) {
                    // Assuming CreateGroupView can update the groups in ViewModel
                    CreateGroupView(groups: $viewModel.groups, isPresented: $isCreateGroupViewPresented)
                }
            }.onAppear {
                viewModel.fetchGroups() // Fetch groups when the view appears
            }
        }
    

     private func deleteGroup(at offsets: IndexSet) {
        groups.remove(atOffsets: offsets)

    }
}

struct GroupDetailView: View {
    let group: Group

    var body: some View {
        Text("Detail view for \(group.name)")
            .navigationBarTitle(group.name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Note: Make sure the Group model is correctly defined and conforms to Identifiable if it's not a Core Data entity.
