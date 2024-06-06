import UIKit
import SwiftUI

extension User {
    func getImage() -> Image? {
        let fileManager = FileManager()
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = documentsDirectory.appendingPathComponent("userImageFolder").appendingPathComponent("\(self.idUser.uuidString)")
        
        if let uiImage = UIImage(contentsOfFile: fileURL.path) {
            return Image(uiImage: uiImage)
        } else {
            return nil
        }
    }
}
