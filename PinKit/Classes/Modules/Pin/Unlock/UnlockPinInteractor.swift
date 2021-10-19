import Foundation
import RxSwift

class UnlockPinInteractor {
    weak var delegate: IUnlockPinInteractorDelegate?

    private let pinManager: IPinManager
    private let biometricManager: IBiometricManager
    private let lockoutManager: ILockoutManager
    private var timer: IOneTimeTimer
    private var biometryManager: IBiometryManager

    private var disposeBag = DisposeBag()

    init(pinManager: IPinManager, biometricManager: IBiometricManager, lockoutManager: ILockoutManager, timer: IOneTimeTimer, biometryManager: IBiometryManager) {
        self.pinManager = pinManager
        self.biometricManager = biometricManager
        self.lockoutManager = lockoutManager
        self.timer = timer
        self.biometryManager = biometryManager

        self.timer.delegate = self
    }

}

extension UnlockPinInteractor: IUnlockPinInteractor {

    var biometryEnabled: Bool {
        pinManager.biometryEnabled
    }

    var biometryType: BiometryType? {
        biometryManager.biometryType
    }

    var failedAttempts: Int {
        lockoutManager.unlockAttempts
    }

    func subscribeBiometryType() {
        biometryManager.biometryTypeObservable
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] biometryType in
                    self?.delegate?.didUpdate(biometryType: biometryType)
                })
                .disposed(by: disposeBag)
    }

    func updateLockoutState() {
        let state = lockoutManager.currentState
        delegate?.update(lockoutState: state)

        if case .locked(let till) = state {
            timer.schedule(date: till)
        }
    }

    func unlock(with pin: String) -> Bool {
        guard pinManager.validate(pin: pin) else {
            lockoutManager.didFailUnlock()

            updateLockoutState()

            return false
        }

        lockoutManager.dropFailedAttempts()
        return true
    }

    func biometricUnlock() {
        biometricManager.validate(reason: "biometric_usage_reason")//
    }

}

extension UnlockPinInteractor: BiometricManagerDelegate {

    func didValidate() {
        delegate?.didBiometricUnlock()
    }

    func didFailToValidate() {
        delegate?.didFailBiometricUnlock()
    }

}

extension UnlockPinInteractor: IPeriodicTimerDelegate {

    func onFire() {
        updateLockoutState()
    }

}
