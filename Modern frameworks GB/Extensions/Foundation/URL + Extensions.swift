import Foundation
import UniformTypeIdentifiers

extension URL {
    func appendingPathComponent(
        directoryKey: UserDocumentDirectoryKey,
        conformingTo contentType: UTType
    ) -> URL {
        appendingPathComponent(directoryKey.rawValue, conformingTo: contentType)
    }
}
