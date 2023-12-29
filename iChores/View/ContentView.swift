//
//  ContentView.swift
//  iChores
//
//  Created by Carolane Lefebvre on 21/12/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var isShowing = false
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    @FetchRequest(sortDescriptors: []) var rooms: FetchedResults<Room>
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    
    var body: some View {
        NavigationStack {
            Section {
                List {
                    ForEach(users) { user in
                        NavigationLink(destination: UserDetailView(user: user)) {
                            Text(user.wrappedUserName)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        let selectedUser = indexSet.map { users[$0] }
                        deleteObject(Set(selectedUser), context: moc)
                    })
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isShowing.toggle()
                    } label: {
                        Label("Add user", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowing) {
                AddUserView()
            }
        }
    }
}

extension ContentView {
    func deleteObject<T: NSManagedObject>(_ objects: Set<T>, context: NSManagedObjectContext) {
        for object in objects {
            context.delete(object)
        }

        do {
            try context.save()
        } catch {
            print("Error while deleting data \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
