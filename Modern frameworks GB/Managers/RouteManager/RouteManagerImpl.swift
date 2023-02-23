import Foundation
import CoreLocation
import GoogleMaps
import RealmSwift

final class RouteManagerImpl: RouteManager {
    
    // MARK: - Private Properties
    private var isTracking: Bool = false
    private let logger = Logger(component: "RouteManagerImpl")
    private var currentRoute = List<LocationObject>()
    private let currentRoutePath = GMSMutablePath()
    private lazy var savedRoute: Results<LocationObject>? = {
        getPreviousRoute()
    }()
    
    // MARK: - Dependencies
    private let realmQueue: DispatchQueue
    
    // MARK: - Init
    init(realmQueue: DispatchQueue) {
        self.realmQueue = realmQueue
    }
    
    // MARK: - RouteManager
    
    func updateLocation(_ update: CurrentLocationUpdate) {
        guard isTracking else { return }
        
        let coordinate = update.currentLocation.coordinate
        let locationObject = LocationObject()
        locationObject.latitude = coordinate.latitude
        locationObject.longitude = coordinate.longitude
        currentRoute.append(locationObject)
    }
    
    func startTracking() {
        isTracking = true
    }
    
    func stopTracking() {
        saveRoute()
        isTracking = false
    }
    
    func showPreviousRoute(onCompletion: @escaping (_ update: PathUpdate?) -> Void) {
        let block: (PathUpdate?) -> Void = { update in
            DispatchQueue.main.async {
                onCompletion(update)
            }
        }
        
        guard isTracking == false else {
            block(nil)
            return
        }
        
        let savedPath = getSavedPath()
        block(savedPath)
    }
}

// MARK: - Private Properties
private extension RouteManagerImpl {
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
    
    func getSavedPath() -> PathUpdate {
        let coordinated = getSavedCoordinates()
        coordinated.forEach {
            currentRoutePath.add($0.coordinate)
        }
        
        return .init(path: currentRoutePath)
    }
    
    func getSavedCoordinates() -> [CLLocation] {
        savedRoute?.forEach {
            currentRoute.append($0)
        }
        
        return currentRoute.map { CLLocation(latitude: $0.latitude, longitude: $0.longitude) }
    }
    
    func getPreviousRoute() -> Results<LocationObject>? {
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
    
    func removeOldRoute() {
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
    
    func clearRoute() {
        currentRoute.removeAll()
    }
}
