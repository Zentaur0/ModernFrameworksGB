import RxSwift

protocol LocationObserver {
    var locationUpdate: BehaviorSubject<CurrentLocationUpdate> { get }
    func startTracking()
    func stopTracking()
}
