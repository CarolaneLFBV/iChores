//
//  UserListView+UsersList.swift
//  iChores
//
//  Created by Carolane Lefebvre on 30/12/2023.
//

import SwiftUI

extension UsersListView {
    var usersList: some View {
        List {
            ForEach(users, id: \.self) { user in
                NavigationLink(destination: UserDetailView(user: user)) {
                    Text(user.wrappedUserName)
                }
            }
            .onDelete(perform: { indexSet in
                do {
                    try userViewModel.deleteUser(at: indexSet, context: moc)
                } catch {
                    print("Error while deleting: \(error.localizedDescription)")
                }
            })
        }
    }
}
