//
//  UserDetailView.swift
//  iChores
//
//  Created by Carolane Lefebvre on 28/12/2023.
//

import SwiftUI

struct UserDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State var userViewModel = UserViewModel()
    @State var isEditing: Bool = false
    @State var modifiedName = ""
    
    let user: User
    
    var body: some View {
        VStack {
            userProfileImage
            
            if isEditing {
                userEdition
            } else {
                userDetail
            }
        }
    }
}

