import Foundation
import CoreLocation

final class MainPresenter: NSObject, MainPresenterProtocol {
    
    // MARK: - Private Properties
    private let logger = Logger(component: "MainPresenter")
    private let locationManager = CLLocationManager()
    private weak var view: MainViewProtocol?
    
    // MARK: - Public Method
    func setView(_ view: MainViewProtocol) {
        self.view = view
    }
    
    // MARK: - MainPresenterProtocol
    func onLoad() {
        setupLocationManager()
    }
    
    func updateCurrentLocation() {
        locationManager.requestLocation()
    }
}

// MARK: - Private Methods
private extension MainPresenter {
    func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
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
        updateViewCurrentLocation(with: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        logger.error(error)
    }
}
