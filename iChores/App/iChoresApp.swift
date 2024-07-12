import SwiftUI

@main
struct iChoresApp: App {
    @StateObject private var dataController = DataController.shared
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "AppPrimaryColor") ?? .black]
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
