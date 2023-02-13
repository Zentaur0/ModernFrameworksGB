import UIKit

final class AppCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    private let viewControllerBuilder: ViewControllerBuilder
    
    // MARK: - Init
    init(navigationController: UINavigationController,
         viewControllerBuilder: ViewControllerBuilder) {
        self.navigationController = navigationController
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func start() {
        openLoginScreen()
    }
    
    func openLoginScreen() {
        let viewController = viewControllerBuilder.buildLoginViewController()
        if let topController = navigationController.topViewController,
              topController !== viewController {
            navigationController.popToRootViewController(animated: true)
            navigationController.setNavigationBarHidden(false, animated: true)
        } else {
            viewController.coordinator = self
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func openMapScreen() {
        let viewController = viewControllerBuilder.buildMainViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
        viewController.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showAlert(_ alert: UIAlertController) {
        navigationController.topViewController?.present(alert, animated: true)
    }
}
