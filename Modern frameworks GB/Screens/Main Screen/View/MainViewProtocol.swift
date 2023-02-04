import CoreLocation

protocol MainViewProtocol: AnyObject {
    func updateMap(with model: MainContentView.Model)
}
