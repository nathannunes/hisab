//
//  ParentView.swift
//  hisab
//
//  Created by Nathan Nunes on 1/18/24.
//

import SwiftUI

struct ParentView: View {
    @State private var isCreateGroupViewPresented = false
    @State private var groups: [Group] = [] // Assuming Group is a valid type

    var body: some View {
        NavigationView {
            // Your content here
            Button("Present Create Group View") {
                isCreateGroupViewPresented = true
            }
            .sheet(isPresented: $isCreateGroupViewPresented) {
                CreateGroupView(groups: $groups, isPresented: $isCreateGroupViewPresented)
            }
        }
    }
}




#Preview {
    ParentView()
}
