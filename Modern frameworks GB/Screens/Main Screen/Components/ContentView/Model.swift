import Foundation
import CoreLocation

extension MainContentView {
    struct Model {
        let currentLocation: CLLocation
    }
    
    struct CameraUpdateModel {
        let firstCoordinate: CLLocationCoordinate2D
        let lastCoordinate: CLLocationCoordinate2D
    }
}
