import Foundation
import RealmSwift

final class LocationObject: Object, ObjectKeyIdentifiable {
    @Persisted var latitude: Double
    @Persisted var longitude: Double
}
