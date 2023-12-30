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
              let imageData = Data(base64Encoded: imageUrlString),
              let uiImage = UIImage(data: imageData) else {
            return nil
        }
    
        return Image(uiImage: uiImage)
    }
}
