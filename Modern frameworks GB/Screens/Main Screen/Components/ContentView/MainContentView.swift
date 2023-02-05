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
    private let currentLocationButton = UIButton()
    
    // MARK: - Action Properties
    private var currenLocationAction: EmptyClosure?
    
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
        let camera = GMSCameraPosition(target: location.coordinate, zoom: 17)
        mapView.camera = camera
        addMarker(for: location.coordinate, to: &currentMarker)
    }
    
    func setCurrentLocationAction(_ action: @escaping EmptyClosure) {
        self.currenLocationAction = action
    }
}

// MARK: - Private Methods
private extension MainContentView {
    func setupUI() {
        backgroundColor = .white
        addSubviews()
        setupButtonsContainer()
        setupCurrentLocationButton()
        setupMapView()
    }
    
    func setupConstraints() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        currentLocationButton.snp.makeConstraints {
            $0.size.equalTo(Const.buttonSize)
        }
        
        buttonsContaner.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(10)
            $0.leading.trailing.equalToSuperview().priority(.low)
            $0.centerX.equalToSuperview()
        }
    }
    
    func addSubviews() {
        addSubview(mapView)
        addSubview(buttonsContaner)
        buttonsContaner.addArrangedSubview(currentLocationButton)
    }
    
    func setupButtonsContainer() {
        buttonsContaner.backgroundColor = .white
        buttonsContaner.axis = .horizontal
        buttonsContaner.distribution = .fillProportionally
        buttonsContaner.alignment = .center
        buttonsContaner.layer.cornerRadius = Const.buttonSize.height / 2
    }
    
    func setupCurrentLocationButton() {
        currentLocationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        currentLocationButton.layer.cornerRadius = Const.buttonSize.height / 2
        currentLocationButton.layer.masksToBounds = true
        currentLocationButton.layer.borderWidth = 0.5
        currentLocationButton.layer.borderColor = UIColor.systemBlue.cgColor
        currentLocationButton.backgroundColor = .systemBlue.withAlphaComponent(0.15)
        currentLocationButton.addTarget(self, action: #selector(didTapCurrentLocationButton), for: .touchUpInside)
    }
    
    func setupMapView() {
        mapView.delegate = self
    }
    
    func addMarker(for coordinate: CLLocationCoordinate2D, to marker: inout GMSMarker?) {
        let newMarker = GMSMarker(position: coordinate)
        newMarker.map = mapView
        marker = newMarker
    }
}

// MARK: - Actions
private extension MainContentView {
    @objc func didTapCurrentLocationButton() {
        currenLocationAction?()
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
