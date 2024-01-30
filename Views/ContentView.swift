//
//  ContentView.swift
//  hisab
//
//  Created by Nathan Nunes on 1/18/24.
//

import SwiftUI
import CoreData


struct CustomHeaderView: View {
    var body: some View {
        Image("hisab_kitab") // Replace with the name of your image asset
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 200) // Adjust the height of the header as needed
            .clipped()
    }
}

struct ContentView: View {
    @State private var isCreateGroupViewPresented = false
    @State private var groups: [Group] = []
    @State private var shouldNavigateToContentView = false
    @StateObject var authViewModel = AuthViewModel()

    var body: some View {
        
        if !authViewModel.isUserAuthenticated {
                        // If not authenticated, present the login view
                        LoginView(authViewModel: authViewModel).modifier(RootViewControllerModifier())
                    }
        NavigationView {
            List {
                if(groups.isEmpty){
                    Text("Please add groups to continue")
                }else{
                    ForEach(groups, id: \.id) { group in
                        NavigationLink(destination: GroupDetailView(group: group)) {
                            Text(group.name)
                        }
                    }
                }
                
            }
            .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                if(!groups.isEmpty){
                                    EditButton()
                                }else{
                                    HStack {
                                        Spacer();Spacer();Spacer();Spacer();Spacer()
                                    }
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
                                Button(action: {
                                    isCreateGroupViewPresented = true
                                }) {
                                    Text("Add Group")
                                        .padding(8)
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .cornerRadius(60)
                                }
                            }
                        }
            
            .sheet(isPresented: $isCreateGroupViewPresented) {
                CreateGroupView(groups: $groups, isPresented: $isCreateGroupViewPresented)
            }
        }
        navigationDestination(isPresented: $shouldNavigateToContentView) {
                        ContentView()
                    }
        
    }
    func performFirebaseOperation() {
            saveUserToFirebase { success in
                DispatchQueue.main.async {
                    if success {
                        self.shouldNavigateToContentView = true
                    } else {
                        // Handle the error case
                    }
                }
            }
        }
}

struct GroupDetailView: View {
    let group: Group

    var body: some View {
        Text("Detail view for \(group.name)")
            .navigationBarTitle(group.name)
    }
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Example groups for preview
//        let groups: [Group] = [
//            Group(id: UUID(), name: "Group 1", expenses: [], personIDs: []),
//            Group(id: UUID(), name: "Group 2", expenses: [], personIDs: [])
//        ]
        return ContentView()
    }
}

