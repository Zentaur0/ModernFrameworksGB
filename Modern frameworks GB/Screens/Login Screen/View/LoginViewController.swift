//
//  LoginViewController.swift
//  Modern frameworks GB
//
//  Created by Антон Сивцов on 13.02.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Public Properties
    var coordinator: AppCoordinator?
    
    // MARK: - Private Properties
    private let contentView = LoginContentView()
    private let presenter: LoginPresenterProtocol
    
    // MARK: - Init
    init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
}

// MARK: - LoginViewProtocol -
extension LoginViewController: LoginViewProtocol {
    func openMainScreen() {
        coordinator?.openMapScreen()
    }
    
    func showUserDoNotExistAlert() {
        let alert = UIAlertController(title: "", message: "User do not exist. Press register", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        coordinator?.showAlert(alert)
    }
    
    func showPasswordHasBeenChangedAlert() {
        let alert = UIAlertController(title: "", message: "Password has been changed", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        coordinator?.showAlert(alert)
    }
}

// MARK: - Private Methods -
private extension LoginViewController {
    func setupActions() {
        contentView.setEnterButtonAction { [unowned self] model in
            self.presenter.didPressEnter(model)
        }
        
        contentView.setRegisterButtonAction { [unowned self] model in
            self.presenter.didPressRegister(model)
        }
    }
}
