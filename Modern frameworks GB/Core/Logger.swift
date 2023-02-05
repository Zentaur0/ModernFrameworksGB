import Foundation

final class Logger {
    
    // MARK: - Private Properties
    private let component: String
    
    // MARK: - Init
    init(component: String) {
        self.component = component
    }
    
    // MARK: - Public Methods
    func info(_ info: Any?) {
        log(#function, info)
    }
    
    func error(_ error: Error) {
        log(#function, String(describing: error))
    }
    
    private func log(_ value: String, _ info: Any?) {
        debugPrint("-- \(value) -- \(component) on thread [\(Thread.current)]: \(String(describing: info))")
    }
}
