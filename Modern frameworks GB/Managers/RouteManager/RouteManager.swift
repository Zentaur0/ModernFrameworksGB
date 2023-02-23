import CoreLocation

protocol RouteManager: AnyObject {
    func startTracking()
    func stopTracking()
    func updateLocation(_ update: CurrentLocationUpdate)
    func showPreviousRoute(onCompletion: @escaping (_ update: PathUpdate?) -> Void)
}
