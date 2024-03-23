//
//  Room+SwiftUI.swift
//  iChores
//
//  Created by Carolane Lefebvre on 21/03/2024.
//

import Foundation

extension Room {
    static let roomTypeToImageName: [String: String] = [
        "Entrance": "house.fill",
        "Living Room": "tv.music.note",
        "Bedroom": "bed.double.fill",
        "Kitchen": "stove.fill",
        "Bathroom": "bathtub.fill",
        "WC": "toilet.fill",
        "Garden": "leaf.arrow.circlepath",
        "Dressing Room": "hanger.fill"
    ]
    
    var roomImageName: String {
        Self.roomTypeToImageName[self.type ?? ""] ?? "questionmark.circle"
    }
}
