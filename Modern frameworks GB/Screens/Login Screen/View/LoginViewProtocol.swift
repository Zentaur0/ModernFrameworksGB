//
//  LoginView.swift
//  Modern frameworks GB
//
//  Created by Антон Сивцов on 13.02.2023.
//

import Foundation

protocol LoginViewProtocol: AnyObject {
    func openMainScreen()
    func showUserDoNotExistAlert()
    func showPasswordHasBeenChangedAlert()
}
