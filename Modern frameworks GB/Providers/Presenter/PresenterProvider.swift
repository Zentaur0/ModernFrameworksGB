import Foundation

final class PresenterProvider {
    
    // MARK: - Private Properties
    private let realmQueue = DispatchQueue(label: "RealmQueue")
    
    // MARK: - Public Methods
    func makeMainPresenter() -> MainPresenter {
        let routeManager = RouteManagerImpl(realmQueue: realmQueue)
        let locationObserver = LocationManager()
        let presenter = MainPresenter(locationObserver: locationObserver, routeManager: routeManager)
        return presenter
    }
    
    func makeLoginPresenter() -> LoginPresenter {
        let userManager = UserManagerImpl(realmQueue: realmQueue)
        let presenter = LoginPresenter(userManager: userManager)
        return presenter
    }
}
