//
//  iChoresApp.swift
//  iChores
//
//  Created by Carolane Lefebvre on 21/12/2023.
//

import SwiftUI

@main
struct iChoresApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
