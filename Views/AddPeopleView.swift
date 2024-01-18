//
//  AddPeopleView.swift
//  hisab
//
//  Created by Nathan Nunes on 1/18/24.
//

import SwiftUI

struct AddPeopleView: View {
    @Binding var isPresented: Bool // Controls whether the sheet is presented
    @Binding var personIDs: [String] // Array of person IDs

    var body: some View {
        NavigationView {
            // Add your search and add people UI here
            Text("Search and Add People")
                .navigationBarTitle("Add People", displayMode: .inline)
                .navigationBarItems(trailing:
                    Button("Done") {
                        // Dismiss the sheet when done
                        isPresented = false
                    }
                )
        }
    }
}


struct AddPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        // Create sample data for the preview
        let isPresented = Binding.constant(true)
        let personIDs = Binding.constant(["Person 1", "Person 2"])

        // Use the AddPeopleView with the sample data
        return AddPeopleView(isPresented: isPresented, personIDs: personIDs)
    }
}
