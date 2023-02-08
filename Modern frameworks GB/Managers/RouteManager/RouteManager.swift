import CoreLocation

protocol RouteManager {
    var isTracking: Bool { get set }
    func appendLocation(_ location: CLLocation)
    func getSavedCoordinates() -> [CLLocation]
    func saveRoute()
}
