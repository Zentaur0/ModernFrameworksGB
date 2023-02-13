import Foundation

final class PresenterProvider {
    
    // MARK: - Private Properties
    private let realmQueue = DispatchQueue(label: "RealmQueue")
    
    // MARK: - Public Methods
    func makeMainPresenter() -> MainPresenter {
        let routeManager = RouteManagerImpl(realmQueue: realmQueue)
        let presenter = MainPresenter(routeManager: routeManager)
        return presenter
    }
        return presenter
    }
}
