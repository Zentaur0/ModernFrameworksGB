//
//  ViewController.swift
//  Modern frameworks GB
//
//  Created by Антон Сивцов on 04.02.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    private let presenter: MainPresenterProtocol
    private let contentView = MainContentView()
    
    // MARK: - Init
    init(presenter: MainPresenterProtocol) {
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
        presenter.onLoad()
    }
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func updateMap(with model: MainContentView.Model) {
        contentView.updateMap(with: model)
    }
}

private extension MainViewController {
    func setupActions() {
        contentView.setCurrentLocationAction { [unowned self] in
            self.presenter.updateCurrentLocation()
        }
    }
}
