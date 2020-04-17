import Foundation

class UnlockPresenterConfiguration {
    var cancellable: Bool
    var enableBiometry: Bool
    var autoBiometry: Bool

    init(cancellable: Bool, enableBiometry: Bool, autoBiometry: Bool) {
        self.cancellable = cancellable
        self.enableBiometry = enableBiometry
        self.autoBiometry = autoBiometry
    }

}

protocol IUnlockPinRouter {
    func dismiss(didUnlock: Bool)
}

protocol IUnlockPinInteractor {
    var failedAttempts: Int { get }
    func updateLockoutState()
    func unlock(with pin: String) -> Bool
    func biometricUnlock()
}

protocol IUnlockPinInteractorDelegate: class {
    func didBiometricUnlock()
    func didFailBiometricUnlock()
    func update(lockoutState: LockoutState)
}
