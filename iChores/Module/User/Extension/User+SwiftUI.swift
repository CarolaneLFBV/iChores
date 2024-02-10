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
        guard let imageUrlString = self.userImage,
              let fileURL = URL(string: imageUrlString),
              let uiImage = UIImage(contentsOfFile: fileURL.path) else {
            return nil
        }
        
        return Image(uiImage: uiImage)
    }
}
