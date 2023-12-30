//
//  UserDetailView+Edition.swift
//  iChores
//
//  Created by Carolane Lefebvre on 30/12/2023.
//

import SwiftUI

extension UserDetailView {
    var userEdition: some View {
        TextField("Name", text: $modifiedName)
    }
}

extension UserDetailView {
    var userDetail: some View {
        Text(user.wrappedUserName)
    }
}

