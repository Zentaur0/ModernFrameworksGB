import Foundation

protocol UserManager {
    func loginUser(_ user: User, completion: @escaping (_ isSuccessful: Bool) -> Void)
    func registerUser(_ newUser: User, completion: @escaping (_ isSuccessful: Bool) -> Void)
}
