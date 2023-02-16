//
//  AppManager.swift
//  Modern frameworks GB
//
//  Created by Антон Сивцов on 04.02.2023.
//

import Foundation

final class AppManager {
    
    // MARK: - Private Properties
    private let presenterProvider = PresenterProvider()
    
    // MARK: - Public Methods
    func makeViewControllerBuilder() -> ViewControllerBuilder {
        let builder = ViewControllerBuilder(presenterProvider: presenterProvider)
        return builder
    }
}
