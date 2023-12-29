//
//  UsersListView.swift
//  iChores
//
//  Created by Carolane Lefebvre on 29/12/2023.
//

import SwiftUI
import CoreData

struct UsersListView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var isShowing = false
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    
    var body: some View {
        NavigationStack {
            Section {
                List {
                    ForEach(users, id: \.self) { user in
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

extension UsersListView {
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
    UsersListView()
}
