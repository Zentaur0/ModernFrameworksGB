import UIKit
import GoogleMaps
import SnapKit

final class MainContentView: UIView {
    
    private struct Const {
        static let buttonSize: CGSize = CGSize(width: 50, height: 50)
    }
    
    // MARK: - Private Properties
    private let mapView = GMSMapView()
    private var currentMarker: GMSMarker?
    private var manualMarker: GMSMarker?
    private let buttonsContaner = UIStackView()
    private let buttonsContainerBackgroundView = UIView()
    private let currentLocationButton = ButtonWithAction()
    private let trackButton = TrackButton()
    private let previousRouteButton = ButtonWithAction()
    private var route: GMSPolyline?
    private var routePath: GMSMutablePath?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
}

// MARK: - Public Methods
extension MainContentView {
    func updateMap(with model: MainContentView.Model) {
        let location = model.currentLocation
        
        routePath?.add(location.coordinate)
        route?.path = routePath
        let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 17)
        mapView.animate(to: position)
    }
    
    func startTracking() {
        routePath = nil
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView
    }
    
    func stopTracking() {
        route = nil
    }
    
    func updateCamera() {
        guard let routePath = routePath else { return }
        let bounds = GMSCoordinateBounds(path: routePath)
        
        mapView.animate(with: GMSCameraUpdate.fit(bounds))
    }
    
    func setCurrentLocationAction(_ action: @escaping EmptyClosure) {
        currentLocationButton.setButtonAction(action)
    }
    
    func setTrackButtonAction(_ action: @escaping (_ shouldStartNewTrack: Bool) -> Void) {
        trackButton.setButtonAction { [unowned self] in
            self.trackButton.toggleState()
            let currentButtonState = self.trackButton.getCurrentState()
            action(currentButtonState == .start)
        }
    }
    
    func setPreviousRouteButtonAction(_ action: @escaping EmptyClosure) {
        previousRouteButton.setButtonAction(action)
    }
}

// MARK: - Private Methods
private extension MainContentView {
    func setupUI() {
        backgroundColor = .white
        addSubviews()
        setupButtonsContainerBackgroundView()
        setupButtonsContainer()
        setupCurrentLocationButton()
        setupTrackButon()
        setupPreviousRouteButton()
        setupMapView()
    }
    
    func setupConstraints() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        buttonsContaner.arrangedSubviews.forEach { subview in
            subview.snp.makeConstraints {
                $0.size.equalTo(Const.buttonSize)
            }
        }
        
        buttonsContaner.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        buttonsContainerBackgroundView.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(10)
            $0.leading.trailing.equalToSuperview().priority(.low)
            $0.centerX.equalToSuperview()
        }
    }
    
    func addSubviews() {
        addSubview(mapView)
        addSubview(buttonsContainerBackgroundView)
        buttonsContainerBackgroundView.addSubview(buttonsContaner)
        buttonsContaner.addArrangedSubview(currentLocationButton)
        buttonsContaner.addArrangedSubview(trackButton)
        buttonsContaner.addArrangedSubview(previousRouteButton)
    }
    
    func setupButtonsContainerBackgroundView() {
        buttonsContainerBackgroundView.backgroundColor = .white
        buttonsContainerBackgroundView.layer.cornerRadius = Const.buttonSize.height / 2
        buttonsContainerBackgroundView.layer.borderColor = UIColor.black.cgColor
        buttonsContainerBackgroundView.layer.borderWidth = 1
        buttonsContainerBackgroundView.layer.masksToBounds = true
    }
    
    func setupButtonsContainer() {
        buttonsContaner.spacing = 10
        buttonsContaner.backgroundColor = .white
        buttonsContaner.axis = .horizontal
        buttonsContaner.distribution = .fillProportionally
        buttonsContaner.alignment = .center
        buttonsContaner.layer.cornerRadius = Const.buttonSize.height / 2
    }
    
    func setupCurrentLocationButton() {
        currentLocationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        setupButton(currentLocationButton, withColor: .systemBlue)
    }
    
    func setupTrackButon() {
        setupStandardButton(trackButton)
    }
    
    func setupPreviousRouteButton() {
        previousRouteButton.setImage(UIImage(systemName: "arrow.down.circle.fill"), for: .normal)
        setupButton(previousRouteButton, withColor: .systemPurple)
    }
    
    func setupButton(_ button: UIButton, withColor color: UIColor) {
        setupStandardButton(button)
        button.layer.borderColor = color.cgColor
        button.tintColor = color
        button.backgroundColor = color.withAlphaComponent(0.15)
    }
    
    func setupStandardButton(_ button: UIButton) {
        button.layer.cornerRadius = Const.buttonSize.height / 2
        button.layer.masksToBounds = true
        button.layer.borderWidth = 0.5
    }
    
    func setupMapView() {
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
    }
    
    func addMarker(for coordinate: CLLocationCoordinate2D, to marker: inout GMSMarker?) {
        let newMarker = GMSMarker(position: coordinate)
        newMarker.map = mapView
        marker = newMarker
    }
}

// MARK: - GMSMapViewDelegate -
extension MainContentView: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if let marker = manualMarker {
            marker.position = coordinate
        } else {
            addMarker(for: coordinate, to: &manualMarker)
        }
    }
}
