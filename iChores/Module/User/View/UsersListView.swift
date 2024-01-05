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

    @State var isShowing = false
    @State var userViewModel = UserViewModel()
    
    var body: some View {
        usersList
    }
}


#Preview {
    UsersListView()
}
