import Foundation

public class Kit {

    public static var localStorage: ILocalStorage {
        UserDefaultsStorage.shared
    }

    public static func secureStorage(service: String) -> ISecureStorage {
        KeychainStorage(service: service)
    }

}

public protocol ILocalStorage {
    func value<T>(for key: String) -> T?
    func set<T>(value: T?, for key: String)
}

public protocol ISecureStorage {
    func value<T: LosslessStringConvertible>(for key: String) -> T?
    func set<T: LosslessStringConvertible>(value: T?, for key: String) throws
    func value(for key: String) -> Data?
    func set(value: Data?, for key: String) throws
    func removeValue(for key: String) throws
}
