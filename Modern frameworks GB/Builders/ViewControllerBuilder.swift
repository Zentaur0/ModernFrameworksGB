import UIKit
import Foundation

final class ViewControllerBuilder {
    
    // MARK: - Private Properties
    private let presenterProvider: PresenterProviderProtocol
    
    // MARK: - Init
    init(presenterProvider: PresenterProviderProtocol) {
        self.presenterProvider = presenterProvider
    }
    
    func buildMainViewController() -> UIViewController {
        let presenter = presenterProvider.makeMainPresenter()
        let viewController = MainViewController(presenter: presenter)
        presenter.setView(viewController)
        return viewController
    }
}
