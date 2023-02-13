protocol MainPresenterProtocol {
    func onLoad()
    func updateCurrentLocation()
    func toogleTrack(_ shouldStartNewTrack: Bool)
    func showPreviousRoute()
}
