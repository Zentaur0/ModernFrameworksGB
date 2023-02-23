import Foundation
import CoreLocation
import RxSwift

final class LocationManager: NSObject, LocationObserver {
    
    // MARK: - LocationObserver Properties
    let locationUpdate = BehaviorSubject(value: CurrentLocationUpdate(currentLocation: .init()))
    
    // MARK: - Dependencies
    private let locationManager = CLLocationManager()
    
    // MARK: - Private Properties
    private let logger = Logger(component: "LocationManager")
    
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
        logger.info(location)
        locationUpdate.onNext(.init(currentLocation: location))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        logger.error(error)
    }
}
