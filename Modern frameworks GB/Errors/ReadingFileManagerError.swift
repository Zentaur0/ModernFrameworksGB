import Foundation

enum ReadingFileManagerError: Error {
    case failedToReadDirectory
    
    var description: String {
        switch self {
        case .failedToReadDirectory:
            return "Failed to read FileManager user directory"
        }
    }
}
