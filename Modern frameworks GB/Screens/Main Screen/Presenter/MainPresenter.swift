import Foundation
import CoreLocation

final class MainPresenter: NSObject, MainPresenterProtocol {
    
    // MARK: - Private Properties
    private let logger = Logger(component: "MainPresenter")
    private var lastLocation: CLLocation?
    private let locationManager = CLLocationManager()
    private var currentRouteLocations: [CLLocation] = []
    private weak var view: MainViewProtocol?
    
    // MARK: - Dependencies
    private var routeManager: RouteManager
    
    // MARK: - Init
    init(routeManager: RouteManager) {
        self.routeManager = routeManager
    }
    
    // MARK: - Public Method
    func setView(_ view: MainViewProtocol) {
        self.view = view
    }
    
    // MARK: - MainPresenterProtocol
    func onLoad() {
        setupLocationManager()
    }
    
    func updateCurrentLocation() {
        guard let lastLocation = lastLocation else { return }
        updateViewCurrentLocation(with: lastLocation)
    }
    
    func toogleTrack(_ shouldStartNewTrack: Bool) {
        shouldStartNewTrack ? startTracking() : stopTracking()
    }
    
    func startTracking() {
        routeManager.isTracking = true
        locationManager.startUpdatingLocation()
        view?.startTracking()
    }
    
    func stopTracking() {
        routeManager.saveRoute()
        routeManager.isTracking = false
        locationManager.stopUpdatingLocation()
        view?.stopTracking()
    }
    
    func showPreviousRoute() {
        guard routeManager.isTracking == false else {
            view?.showNotPermittedAlert()
            return
        }
        
        let savedCoordinates = routeManager.getSavedCoordinates()
        
        DispatchQueue.main.async { [weak self] in
            savedCoordinates.forEach {
                self?.updateViewCurrentLocation(with: $0)
            }
            
            self?.view?.updateCamera()
        }
    }
}

// MARK: - Private Methods
private extension MainPresenter {
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func updateViewCurrentLocation(with location: CLLocation) {
        let model = MainContentView.Model(currentLocation: location)
        view?.updateMap(with: model)
    }
}

// MARK: - CLLocationManagerDelegate -
extension MainPresenter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
        updateViewCurrentLocation(with: location)
        logger.info(location)
        
        if routeManager.isTracking {
            routeManager.appendLocation(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        logger.error(error)
    }
}
