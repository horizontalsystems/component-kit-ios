import UIKit
import LanguageKit
import StorageKit
import RxSwift

public class Kit {
    private let secureStorage: ISecureStorage
    private let localStorage: ILocalStorage

    private let pinManager: IPinManager
    private let lockManager: ILockManager & IUnlockDelegate
    private let lockoutManager: ILockoutManager

    public init(secureStorage: ISecureStorage, localStorage: ILocalStorage) {
        self.secureStorage = secureStorage
        self.localStorage = localStorage

        pinManager = PinManager(secureStorage: secureStorage, localStorage: localStorage)
        lockManager = LockManager(pinManager: pinManager, localStorage: localStorage)

        let uptimeProvider = UptimeProvider()
        let lockoutUntilDateFactory = LockoutUntilDateFactory(currentDateProvider: CurrentDateProvider())
        lockoutManager = LockoutManager(secureStorage: secureStorage, uptimeProvider: uptimeProvider, lockoutTimeFrameFactory: lockoutUntilDateFactory)
    }

}

extension Kit: IPinKit {

    public func set(delegate: IPinKitDelegate?) {
        lockManager.delegate = delegate
    }

    public var isPinSet: Bool {
        pinManager.isPinSet
    }

    public var isPinSetObservable: Observable<Bool> {
        pinManager.isPinSetObservable
    }

    public func clear() throws {
        try pinManager.clear()
    }

    public var biometryEnabled: Bool {
        get {
            pinManager.biometryEnabled
        }
        set {
            pinManager.biometryEnabled = newValue
        }
    }


    public var isLocked: Bool {
        lockManager.isLocked
    }

    public func lock() {
        lockManager.lock()
    }

    public func didEnterBackground() {
        lockManager.didEnterBackground()
    }

    public func willEnterForeground() {
        lockManager.willEnterForeground()
    }

    public var editPinModule: UIViewController {
        EditPinRouter.module(pinManager: pinManager)
    }

    public func setPinModule(delegate: ISetPinDelegate) -> UIViewController {
        SetPinRouter.module(delegate: delegate, pinManager: pinManager)
    }

    public func unlockPinModule(delegate: IUnlockDelegate, enableBiometry: Bool, unlockMode: UnlockMode) -> UIViewController {
        UnlockPinRouter.module(delegate: delegate, lockManagerDelegate: lockManager, pinManager: pinManager, lockoutManager: lockoutManager, enableBiometry: enableBiometry, unlockMode: unlockMode)
    }

}
