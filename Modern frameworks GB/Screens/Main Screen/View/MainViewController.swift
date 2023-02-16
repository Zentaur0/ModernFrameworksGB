//
//  ViewController.swift
//  Modern frameworks GB
//
//  Created by Антон Сивцов on 04.02.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Public Properties
    var coordinator: AppCoordinator?
    
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
    
    func startTracking() {
        contentView.startTracking()
    }
    
    func stopTracking() {
        contentView.stopTracking()
    }
    
    func showNotPermittedAlert() {
        let alert = UIAlertController(title: "", message: "Current tracking has to be stopped in order to show previos route", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Ok", style: .destructive) { [unowned self] _ in
            self.stopTracking()
            self.presenter.toogleTrack(false)
            self.presenter.showPreviousRoute()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(okayAction)
        alert.addAction(cancelAction)
        
        coordinator?.showAlert(alert)
    }
    
    func logout() {
        coordinator?.openLoginScreen()
    }
    
    func updateCamera(with path: MainContentView.CameraUpdatePath) {
        contentView.updateCamera(with: path)
    }
}

private extension MainViewController {
    func setupActions() {
        contentView.setCurrentLocationAction { [unowned self] in
            self.presenter.updateCurrentLocation()
        }
        
        contentView.setTrackButtonAction { [unowned self] shouldStartNewTrack in
            self.presenter.toogleTrack(shouldStartNewTrack)
        }
        
        contentView.setPreviousRouteButtonAction { [unowned self] in
            self.presenter.showPreviousRoute()
        }
        
        contentView.setLogoutButtonAction { [unowned self] in
            self.presenter.logout()
        }
    }
}
