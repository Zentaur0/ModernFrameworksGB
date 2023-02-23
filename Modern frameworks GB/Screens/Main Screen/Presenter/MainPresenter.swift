import Foundation

final class MainPresenter: NSObject, MainPresenterProtocol {
    
    // MARK: - Private Properties
    private weak var view: MainViewProtocol?
    
    // MARK: - Dependencies
    private let locationObserver: LocationObserver
    private var routeManager: RouteManager
    
    // MARK: - Init
    init(locationObserver: LocationObserver,
         routeManager: RouteManager) {
        self.locationObserver = locationObserver
        self.routeManager = routeManager
    }
    
    // MARK: - Public Method
    func setView(_ view: MainViewProtocol) {
        self.view = view
    }
    
    // MARK: - MainPresenterProtocol
    func onLoad() {
        locationObserver.locationUpdate
            .asObservable()
            .bind { [weak self] update in
                self?.updateViewCurrentLocation(with: update)
            }.dispose()
    }
    
    func updateCurrentLocation() {
        do {
            let locationUpdate = try locationObserver.locationUpdate.value()
            updateViewCurrentLocation(with: locationUpdate)
        } catch {
            print(error)
        }
    }
    
    func toogleTrack(_ shouldStartNewTrack: Bool) {
        shouldStartNewTrack ? startTracking() : stopTracking()
    }
    
    func showPreviousRoute() {
        routeManager.showPreviousRoute { [weak view] update in
            guard let update = update else {
                view?.showNotPermittedAlert()
                return
            }
            
            view?.updateCamera(with: .init(path: update.path))
        }
    }
    
    func logout() {
        view?.logout()
    }
}

// MARK: - Private Methods
private extension MainPresenter {
    func updateViewCurrentLocation(with update: CurrentLocationUpdate) {
        let model = MainContentView.Model(currentLocation: update.currentLocation)
        view?.updateMap(with: model)
    }
    
    func startTracking() {
        routeManager.startTracking()
        locationObserver.startTracking()
        view?.startTracking()
    }
    
    func stopTracking() {
        routeManager.stopTracking()
        locationObserver.stopTracking()
        view?.stopTracking()
    }
}
