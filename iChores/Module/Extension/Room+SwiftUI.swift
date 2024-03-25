import Foundation

extension Room {
    static let roomTypeToImageName: [String: String] = [
        "Entrance": "house.fill",
        "Living Room": "sofa.fill",
        "Bedroom": "bed.double.fill",
        "Kitchen": "stove.fill",
        "Bathroom": "shower.fill",
        "WC": "toilet.fill",
        "Garden": "tree.fill",
        "Dressing Room": "hanger"
    ]
    
    var roomImageName: String {
        Self.roomTypeToImageName[self.type ?? ""] ?? "questionmark.circle"
    }
}
