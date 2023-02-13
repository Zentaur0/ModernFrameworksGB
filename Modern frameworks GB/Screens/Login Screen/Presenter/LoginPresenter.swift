import Foundation

final class LoginPresenter: LoginPresenterProtocol {
    
    // MARK: - Dependencies
    private let userManager: UserManager
    
    // MARK: - Private Properties
    private let logger = Logger(component: "LoginPresenter")
    private weak var view: LoginViewProtocol?
    
    // MARK: - Init
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    // MARK: - Public Methods
    func setView(_ view: LoginViewProtocol) {
        self.view = view
    }
    
    // MARK: - LoginPresenterProtocol
    func didPressEnter(_ model: LoginContentView.Model) {
        let user = User()
        user.login = model.login
        user.password = model.password
        userManager.loginUser(user) { [weak self] value in
            if value == true {
                self?.view?.openMainScreen()
            } else {
                self?.view?.showUserDoNotExistAlert()
            }
        }
    }
    
    func didPressRegister(_ model: LoginContentView.Model) {
        let user = User()
        user.login = model.login
        user.password = model.password
        userManager.registerUser(user) { [weak self] value in
            if value == true {
                self?.view?.showPasswordHasBeenChangedAlert()
                self?.view?.openMainScreen()
            } else {
                self?.logger.info("Something went wrong")
            }
        }
    }
}
