final class PresenterProvider: PresenterProviderProtocol {
    func makeMainPresenter() -> MainPresenter {
        let presenter = MainPresenter(routeManager: RouteManagerImpl())
        return presenter
    }
}
