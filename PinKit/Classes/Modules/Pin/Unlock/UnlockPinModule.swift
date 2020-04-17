import Foundation

class UnlockPresenterConfiguration {
    var cancellable: Bool
    var biometryUnlockMode: BiometryUnlockMode

    init(cancellable: Bool, biometryUnlockMode: BiometryUnlockMode) {
        self.cancellable = cancellable
        self.biometryUnlockMode = biometryUnlockMode
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
