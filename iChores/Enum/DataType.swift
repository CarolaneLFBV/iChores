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
    
    var addData: String {
        switch self {
        case .room:
            return "Add a room with the + button"
        case .user:
            return "Add a user with the + button"
        case .chore:
            return "Add a chore with the + button"
        }
    }
}
