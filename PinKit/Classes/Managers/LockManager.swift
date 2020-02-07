import Foundation
import StorageKit

class LockManager {
    private let lastExitDateKey = "last_exit_date_key"

    private let pinManager: IPinManager
    private let localStorage: ILocalStorage

    private let lockTimeout: Double = 60
    private(set) var isLocked: Bool

    weak var delegate: IPinKitDelegate?

    init(pinManager: IPinManager, localStorage: ILocalStorage) {
        self.pinManager = pinManager
        self.localStorage = localStorage

        isLocked = pinManager.isPinSet
    }

}

extension LockManager: ILockManager {

    func didEnterBackground() {
        guard !isLocked else {
            return
        }

        localStorage.set(value: Date().timeIntervalSince1970, for: lastExitDateKey)
    }

    func willEnterForeground() {
        guard !isLocked else {
            return
        }

        let exitTimestamp: TimeInterval = localStorage.value(for: lastExitDateKey) ?? 0
        let now = Date().timeIntervalSince1970

        guard now - exitTimestamp > lockTimeout else {
            return
        }

        lock()
    }

    func lock() {
        guard pinManager.isPinSet else {
            return
        }

        isLocked = true
        delegate?.onLock(delegate: self)
    }

}

extension LockManager: IUnlockDelegate {

    func onUnlock() {
        isLocked = false
    }

    func onCancelUnlock() {
    }

}
