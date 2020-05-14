import PinKit
import StorageKit

class App {
    private static let secureService = "test_pin_kit_service"
    static let shared = App()

    let pinKit: IPinKit
    let pinKitDelegate: PinKitDelegate
    let keychainKit: IKeychainKit

    init() {
        pinKitDelegate = PinKitDelegate()
        keychainKit = KeychainKit(service: App.secureService)
        pinKit = PinKit.Kit(secureStorage: keychainKit.secureStorage, localStorage: StorageKit.LocalStorage.default)
        pinKit.set(delegate: pinKitDelegate)
        pinKit.biometryEnabled = true
    }

}
