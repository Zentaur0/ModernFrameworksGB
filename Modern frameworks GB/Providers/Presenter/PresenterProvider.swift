final class PresenterProvider: PresenterProviderProtocol {
    func makeMainPresenter() -> MainPresenter {
        let presenter = MainPresenter()
        return presenter
    }
}
