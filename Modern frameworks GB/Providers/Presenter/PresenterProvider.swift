final class PresenterProvider {
    func makeMainPresenter() -> MainPresenter {
        let presenter = MainPresenter(routeManager: RouteManagerImpl())
        return presenter
    }
}
