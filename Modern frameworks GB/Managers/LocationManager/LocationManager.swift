import Foundation
import CoreLocation

final class LocationManager: NSObject, LocationObserver {
    
    // MARK: - Dependencies
    private let locationManager = CLLocationManager()
    
    // MARK: - Private Properties
    private let logger = Logger(component: "LocationManager")
    private var lastLocation: CLLocation?
    private var currentRouteLocations: [CLLocation] = []
    
    private var onLocationUpdate: ((CurrentLocationUpdate) -> Void)?
    
    // MARK: - Init
    override init() {
        super.init()
        setupLocationManager()
    }
    
    func onLoad() {
        setupLocationManager()
    }
    
    func toogleTrack(_ shouldStartNewTrack: Bool) {
        shouldStartNewTrack ? startTracking() : stopTracking()
    }
    
    func startTracking() {
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }

    func getCurrentLocationUpdate() -> CurrentLocationUpdate {
        return .init(currentLocation: lastLocation ?? .init())
    }
    
    func setOnLocationUpdate(_ action: @escaping (CurrentLocationUpdate) -> Void) {
        self.onLocationUpdate = action
    }
}

// MARK: - Private Methods
private extension LocationManager {
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }
}

// MARK: - CLLocationManagerDelegate -
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
        logger.info(location)
        
        onLocationUpdate?(.init(currentLocation: location))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        logger.error(error)
    }
}
