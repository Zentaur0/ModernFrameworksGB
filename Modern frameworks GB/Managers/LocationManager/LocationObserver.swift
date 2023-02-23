protocol LocationObserver {
    func setOnLocationUpdate(_ action: @escaping (CurrentLocationUpdate) -> Void)
    func getCurrentLocationUpdate() -> CurrentLocationUpdate
    func startTracking()
    func stopTracking()
}
