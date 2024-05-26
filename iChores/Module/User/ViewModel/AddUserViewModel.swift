import SwiftUI
import CoreData

@Observable
final class AddUserViewModel {
    var showingImagePicker: Bool = false
    var userCoreDataHelper = UserCoreDataHelper()
    
    var fileManager = FileManager()
    
    var user: User?
    
    func addUser(name: String, image: UIImage?) throws {
        let user = User(context: userCoreDataHelper.moc)
        user.idUser = UUID()
        user.name = name
        
        if let image {
            let imageURL = try fileManager.saveImageToDocumentsDirectory(image, fileName: user.idUser)
            user.userImage = imageURL?.absoluteString
        }
        
        try userCoreDataHelper.moc.save()
        try userCoreDataHelper.fetch()
    }
    
    func isValidName(_ name: String) -> Bool {
        userCoreDataHelper.isValidName(name)
    }
}
