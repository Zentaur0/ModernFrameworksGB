import CoreLocation
import GoogleMaps

protocol RouteManager {
    var isTracking: Bool { get set }
    func appendLocation(_ location: CLLocation)
    func getSavedPath() -> GMSMutablePath
    func saveRoute()
}
