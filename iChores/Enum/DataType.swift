enum DataType {
    case user, room, chore
}

extension DataType {
    var imageName: String {
        switch self {
        case .room:
            return "square.split.bottomrightquarter"
        case .user:
            return "person.fill"
        case .chore:
            return "circle.inset.filled"
        }
    }
    
    var noDataSelectedText: String {
        switch self {
        case .room, .user, .chore:
            return "None"
        }
    }
    
    var noDataFoundText: String {
        switch self {
        case .room:
            return "No Rooms Found"
        case .user:
            return "No Users Found"
        case .chore:
            return "No Chores Found"
        }
    }
}
