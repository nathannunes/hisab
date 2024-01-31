//
//  GroupsView.swift
//  hisab
//
//  Created by Nathan Nunes on 1/30/24.
//

import SwiftUI

struct GroupsView: View {
    @ObservedObject var viewModel = GroupsViewModel()

    var body: some View {
        List(viewModel.groups, id: \.id) { group in
            Text(group.name)
        }
    }
}

#Preview {
    GroupsView()
}
