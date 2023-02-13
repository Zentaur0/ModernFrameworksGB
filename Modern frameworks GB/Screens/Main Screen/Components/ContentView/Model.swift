import Foundation
import CoreLocation
import GoogleMaps

extension MainContentView {
    struct Model {
        let currentLocation: CLLocation
    }
    
    struct CameraUpdatePath {
        let path: GMSMutablePath
    }
}
