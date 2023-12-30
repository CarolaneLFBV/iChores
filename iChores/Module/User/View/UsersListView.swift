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
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>

    @State private var isShowing = false
    @State var userViewModel = UserViewModel()
    
    var body: some View {
        Section {
            usersList
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
        .onAppear {
            do {
                try userViewModel.fetchUsers(context: moc)
            } catch {
                // TODO: turn into alert
                print("Error while fetching users: \(error.localizedDescription)")
            }
        }
        
    }

}


#Preview {
    UsersListView()
}
