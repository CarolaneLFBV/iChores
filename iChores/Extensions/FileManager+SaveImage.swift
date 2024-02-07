//
//  FileManager-SaveImage.swift
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

    func saveImageToDocumentsDirectory(_ image: UIImage, fileName: String) throws -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ImageSaveError.documentsDirectoryNotFound
        }

        let fileURL = documentsDirectory.appendingPathComponent("userImage").appendingPathComponent(fileName)

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
