import CoreLocation

protocol MainViewProtocol: AnyObject {
    func updateMap(with model: MainContentView.Model)
    func startTracking()
    func stopTracking()
    func showNotPermittedAlert()
}
