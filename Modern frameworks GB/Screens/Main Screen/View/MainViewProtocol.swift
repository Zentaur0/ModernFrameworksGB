import CoreLocation
import GoogleMaps

protocol MainViewProtocol: AnyObject {
    func updateMap(with model: MainContentView.Model)
    func startTracking()
    func stopTracking()
    func showNotPermittedAlert()
    func updateCamera(with path: CameraUpdatePath)
}

struct CameraUpdatePath {
    let path: GMSMutablePath
}
