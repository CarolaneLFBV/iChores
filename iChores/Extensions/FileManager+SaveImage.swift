import Foundation
import UIKit

extension FileManager {
    
    enum ImageSaveError: Error {
        case documentsDirectoryNotFound, imageConversionFailed, fileWriteError(Error), directoryNotCreated
    }
    
    func saveImageToDocumentsDirectory(_ image: UIImage, fileName: UUID) throws -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ImageSaveError.documentsDirectoryNotFound
        }
        
        let userImageDirectory = documentsDirectory.appendingPathComponent("userImageFolder")

        do {
            try FileManager.default.createDirectory(at: userImageDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            throw ImageSaveError.directoryNotCreated
        }
        
        let fileURL = userImageDirectory.appendingPathComponent("\(fileName)")

        guard let data = image.pngData() else {
            throw ImageSaveError.imageConversionFailed
        }
        
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch let error{
            throw ImageSaveError.fileWriteError(error)
        }
    }
}
