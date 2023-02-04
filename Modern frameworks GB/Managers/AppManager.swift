//
//  AppManager.swift
//  Modern frameworks GB
//
//  Created by Антон Сивцов on 04.02.2023.
//

import Foundation

final class AppManager {
    func makeViewControllerBuilder() -> ViewControllerBuilder {
        let presenterProvider = makePresenterProvider()
        let builder = ViewControllerBuilder(presenterProvider: presenterProvider)
        return builder
    }
    
    private func makePresenterProvider() -> PresenterProviderProtocol {
        PresenterProvider()
    }
}
