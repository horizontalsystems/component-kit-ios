import LocalAuthentication

class PasscodeLockManager {
    weak var delegate: IKeychainKitDelegate?

    private(set) var locked: Bool = false

    func handleLaunch() {
        if !passcodeSet {
            lock()
        }
    }

    func handleForeground() {
        if passcodeSet {
            unlockIfRequired()
        } else {
            lockIfRequired()
        }
    }

    private func lockIfRequired() {
        guard !locked else {
            return
        }

        lock()
        delegate?.onLock()
    }

    private func unlockIfRequired() {
        guard locked else {
            return
        }

        locked = false
        delegate?.onUnlock()
    }

    private func lock() {
        locked = true

        delegate?.onInitialLock()
    }

    private var passcodeSet: Bool {
        LAContext().canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
    }

}
