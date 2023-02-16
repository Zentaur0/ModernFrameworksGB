import Foundation
import RealmSwift

final class UserManagerImpl: UserManager {
    
    private let realmQueue: DispatchQueue
    
    init(realmQueue: DispatchQueue) {
        self.realmQueue = realmQueue
    }
    
    // MARK: - Private Properties
    private let logger = Logger(component: "UserManager")
    
    // MARK: - UserManager
    func loginUser(_ user: User, completion: @escaping (_ isSuccessful: Bool) -> Void) {
        do {
            let realm = try Realm()
            let existedUser = realm.object(ofType: User.self, forPrimaryKey: user.login)
            let isSuccess = existedUser != nil && user.password == existedUser?.password
            completion(isSuccess)
        } catch {
            logger.error(error)
            completion(false)
        }
    }
    
    func registerUser(_ newUser: User, completion: @escaping (_ isSuccessful: Bool) -> Void) {
        do {
            let realm = try Realm()
            
            try realm.write {
                guard isUserExists(newUser) else {
                    realm.add(newUser)
                    completion(isUserExists(newUser))
                    return
                }
                
                guard let existedUser = realm.object(ofType: User.self, forPrimaryKey: newUser.login) else {
                    completion(false)
                    return
                }
                existedUser.password = newUser.password
                realm.add(existedUser, update: .modified)
                
                completion(isUserExists(newUser))
            }
        } catch {
            logger.error(error)
            completion(false)
        }
    }
    
    // MARK: - Private Methods
    private func isUserExists(_ checkingUser: User) -> Bool {
        do {
            let realm = try Realm()
            let users = realm.objects(User.self)
            
            var isSuccess = false
            
            for user in users where user.login == checkingUser.login {
                isSuccess = true
            }
            
            return isSuccess
        } catch {
            logger.error(error)
            return false
        }
    }
}
