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
    @State private var groups: [Group] = []
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink(destination: Text("Item at \(item.timestamp!, formatter: itemFormatter)")) {
                        Text(item.timestamp!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .principal) {
                                    Image("hisab_kitab")
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                        .clipShape(Rectangle().offset(x: 10, y: 25).size(width: 120, height: 60))
                                        
                                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CreateGroupView(groups: $groups)) {
                        Text("Add Group")
                            .padding(9)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(50)
                    }
                }

            }
            
        }
    }

    private func addItem() {
        withAnimation {
            //let newItem = CreateGroupView()
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
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
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
