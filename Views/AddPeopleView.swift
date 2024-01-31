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
            SearchAndListView(isPresented: $isPresented)
    }
}

struct SearchAndListView: View {
    @Binding var isPresented: Bool
    @State private var searchForPeople = ""

    var body: some View {
        NavigationView {
            Text("\(searchForPeople)")
            .navigationTitle("People on Hisab Kitab")
            .searchable(text: $searchForPeople)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        // Dismiss the sheet when done
                        isPresented = false
                    }
                }
            }
        }
    }
}



struct AddPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        // Create sample data for the preview
        let isPresented = Binding.constant(true)
        let personIDs = Binding.constant(["Person 1"])

        // Use the AddPeopleView with the sample data
        return AddPeopleView(isPresented: isPresented, personIDs: personIDs)
    }
}
