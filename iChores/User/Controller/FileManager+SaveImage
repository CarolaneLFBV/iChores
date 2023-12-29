//
//  FileManager-DocumentsDirectory.swift
//  iChores
//
//  Created by Carolane Lefebvre on 29/12/2023.
//

import Foundation
import UIKit

extension FileManager {
    
    enum ImageSaveError: Error {
        case documentsDirectoryNotFound, imageConversionFailed, fileWriteError(Error)
    }

    func saveImageToDocumentsDirectory(image: UIImage, fileName: String) throws -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ImageSaveError.documentsDirectoryNotFound
        }

        let fileURL = documentsDirectory.appendingPathComponent("userImage").appendingPathComponent(fileName)

        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            throw ImageSaveError.imageConversionFailed
        }

        do {
            try imageData.write(to: fileURL)
            return fileURL
        } catch let error{
            throw ImageSaveError.fileWriteError(error)
        }
    }
}
