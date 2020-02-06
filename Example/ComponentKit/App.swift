import PinKit
import StorageKit

class App {
    private static let secureService = "test_pin_kit_service"
    static let shared = App()

    let pinKit: IPinKit
    let keychainKit: IKeychainKit
    let lockProvider: ILockProvider

    init() {
        lockProvider = LockProvider()
        keychainKit = KeychainKit(service: App.secureService)
        pinKit = PinKit.Kit(secureStorage: keychainKit.secureStorage, localStorage: StorageKit.LocalStorage.default, lockProvider: lockProvider)
    }

}