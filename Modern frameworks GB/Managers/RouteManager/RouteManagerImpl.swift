import Foundation
import CoreLocation
import RealmSwift

final class RouteManagerImpl: RouteManager {
    
    var isTracking: Bool = false
    
    // MARK: - Private Properties
    private let logger = Logger(component: "MainPresenter")
    private var currentRoute = List<LocationObject>()
    private lazy var savedRoute: Results<LocationObject>? = {
        realmQueue.sync {
            getPreviousRoute()
        }
    }()
    
    private let realmQueue = DispatchQueue(label: "RouteManagerQueue")
    private var routeToken: NotificationToken?
    
    func appendLocation(_ location: CLLocation) {
        let coordinate = location.coordinate
        let locationObject = LocationObject()
        locationObject.latitude = coordinate.latitude
        locationObject.longitude = coordinate.longitude
        currentRoute.append(locationObject)
    }
    
    func saveRoute() {
        removeOldRoute()
        realmQueue.sync {
            do {
                let realm = try Realm()
                
                try realm.write {
                    realm.add(currentRoute)
                    currentRoute.removeAll()
                }
            } catch {
                logger.error(error)
            }
        }
    }
    
    
    func getSavedCoordinates() -> [CLLocation] {
        savedRoute?.forEach {
            currentRoute.append($0)
        }
        
        return currentRoute.map { CLLocation(latitude: $0.latitude, longitude: $0.longitude) }
    }
    
    private func getPreviousRoute() -> Results<LocationObject>? {
        realmQueue.sync {
            do {
                let realm = try Realm()
                return realm.objects(LocationObject.self)
            } catch {
                logger.error(error)
                return nil
            }
        }
    }
    
    private func removeOldRoute() {
        guard savedRoute?.isEmpty == false else { return }
        realmQueue.sync {
            do {
                let realm = try Realm()
                
                try realm.write {
                    realm.delete(realm.objects(LocationObject.self))
                }
            } catch {
                logger.error(error)
            }
        }
    }
    
    private func clearRoute() {
        currentRoute.removeAll()
    }
}
