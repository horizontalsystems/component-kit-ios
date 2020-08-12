import RxSwift
import StorageKit

class PinManager {
    private let biometricOnKey = "biometric_on_key"
    private let pinKey = "pin_keychain_key"

    private let secureStorage: ISecureStorage
    private let localStorage: ILocalStorage

    private let isPinSetSubject = PublishSubject<Bool>()

    init(secureStorage: ISecureStorage, localStorage: ILocalStorage) {
        self.secureStorage = secureStorage
        self.localStorage = localStorage
    }

}

extension PinManager: IPinManager {

    var isPinSet: Bool {
        secureStorage.value(for: pinKey) != nil
    }

    var biometryEnabled: Bool {
        get {
            localStorage.value(for: biometricOnKey) ?? false
        }
        set {
            localStorage.set(value: newValue, for: biometricOnKey)
        }
    }

    func store(pin: String) throws {
        try secureStorage.set(value: pin, for: pinKey)
        isPinSetSubject.onNext(true)
    }

    func validate(pin: String) -> Bool {
        secureStorage.value(for: pinKey) == pin
    }

    func clear() throws {
        try secureStorage.removeValue(for: pinKey)
        localStorage.set(value: false, for: biometricOnKey)
        isPinSetSubject.onNext(false)
    }

    var isPinSetObservable: Observable<Bool> {
        isPinSetSubject.asObservable()
    }

}
