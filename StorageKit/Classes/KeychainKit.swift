public class KeychainKit {
    private let keyDidLaunchOnce = "did_launch_once_key"

    private let localStorage = LocalStorage.default
    private let keychain: KeychainStorage
    private let manager: PasscodeLockManager

    public init(service: String) {
        keychain = KeychainStorage(service: service)
        manager = PasscodeLockManager()
    }

    private func handleDidLaunchOnce() {
        let didLaunchOnce = localStorage.value(for: keyDidLaunchOnce) ?? false

        if !didLaunchOnce {
            try? keychain.clear()
            localStorage.set(value: true, for: keyDidLaunchOnce)
        }
    }

}

extension KeychainKit: IKeychainKit {

    public var secureStorage: ISecureStorage {
        keychain
    }

    public func set(delegate: IKeychainKitDelegate?) {
        manager.delegate = delegate
    }

    public var locked: Bool {
        manager.locked
    }

    public func handleLaunch() {
        handleDidLaunchOnce()
        manager.handleLaunch()
    }

    public func handleForeground() {
        manager.handleForeground()
    }

}
