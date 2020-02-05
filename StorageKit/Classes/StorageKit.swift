import UIKit
import LanguageKit

class StorageKit {

    static var bundle: Bundle? {
        Bundle(for: StorageKit.self).url(forResource: "StorageKit", withExtension: "bundle").flatMap { Bundle(url: $0) }
    }

    static func image(named: String) -> UIImage? {
        UIImage(named: named, in: bundle, compatibleWith: nil)
    }

}

extension String {

    var localized: String {
        LanguageManager.shared.localize(string: self, bundle: StorageKit.bundle)
    }

    func localized(_ arguments: CVarArg...) -> String {
        LanguageManager.shared.localize(string: self, bundle: StorageKit.bundle, arguments: arguments)
    }

}

public class LocalStorage {

    public static var `default`: ILocalStorage {
        userDefaults
    }

    public static let userDefaults: ILocalStorage = UserDefaultsStorage()

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

public protocol IKeychainKit {
    var secureStorage: ISecureStorage { get }
    var locked: Bool { get }
    func set(delegate: IKeychainKitDelegate?)
    func handleLaunch()
    func handleForeground()
}

public protocol IKeychainKitDelegate: AnyObject {
    func onInitialLock()
    func onLock()
    func onUnlock()
}
