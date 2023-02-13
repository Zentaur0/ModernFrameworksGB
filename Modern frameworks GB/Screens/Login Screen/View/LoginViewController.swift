//
//  LoginViewController.swift
//  Modern frameworks GB
//
//  Created by Антон Сивцов on 13.02.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Private Properties
    private let contentView = LoginContentView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - LoginViewProtocol -
extension LoginViewController: LoginViewProtocol {
    func openMainScreen() {
        
    }
    
    func showUserDoNotExistAlert() {
        
    }
    
    func showPasswordHasBeenChangedAlert() {
        
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
