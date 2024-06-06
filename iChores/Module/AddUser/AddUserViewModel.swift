import SwiftUI
import CoreData

@Observable
final class AddUserViewModel {
    var userRepository = UserRepository()
    var showingImagePicker: Bool = false
    
    var name: String = ""
    var image: UIImage?
    
    func addUser(name: String, image: UIImage?) {
        userRepository.add(name: name, image: image)
    }
    
    func isValidName(_ name: String) -> Bool {
        userRepository.isValidName(name)
    }
}
