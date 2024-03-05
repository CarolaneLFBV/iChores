//
//  User+SwiftUI.swift
//  iChores
//
//  Created by Carolane Lefebvre on 29/12/2023.
//

import UIKit
import SwiftUI

extension User {
    func getImage() -> Image? {
        let fileManager = FileManager()
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = documentsDirectory.appendingPathComponent("userImageFolder").appendingPathComponent("\(self.id.uuidString)")
        
        if let uiImage = UIImage(contentsOfFile: fileURL.path) {
            return Image(uiImage: uiImage)
        } else {
            return nil
        }
    }
}
