protocol MainPresenterProtocol {
    func onLoad()
    func updateCurrentLocation()
    func toogleTrack(_ shouldStartNewTrack: Bool)
    func showPreviousRoute()
    func logout()
    func showImagePicker()
    func saveMarkerModel(_ model: ImagePickerController.Model)
}
