import Foundation

class UnlockPinPresenter {

    enum Page: Int { case unlock }

    weak var view: IPinView?
    private let interactor: IUnlockPinInteractor
    private let router: IUnlockPinRouter
    private let lockManagerDelegate: IUnlockDelegate

    private let configuration: UnlockPresenterConfiguration

    init(interactor: IUnlockPinInteractor, router: IUnlockPinRouter, lockManagerDelegate: IUnlockDelegate, configuration: UnlockPresenterConfiguration = .init(cancellable: false, enableBiometry: true, autoBiometry: true)) {
        self.interactor = interactor
        self.router = router
        self.lockManagerDelegate = lockManagerDelegate
        self.configuration = configuration
    }

}

extension UnlockPinPresenter: IPinViewDelegate {

    func viewDidLoad() {
        view?.addPage(withDescription: "unlock_pin.info")

        if interactor.failedAttempts == 0, configuration.enableBiometry, configuration.autoBiometry {
            interactor.biometricUnlock()
        }

        if configuration.cancellable {
            view?.showCancel()
        }

        interactor.updateLockoutState()
    }

    func onEnter(pin: String, forPage index: Int) {
        if interactor.unlock(with: pin) {
            lockManagerDelegate.onUnlock()
            router.dismiss(didUnlock: true)
        } else {
            view?.showPinWrong(page: Page.unlock.rawValue)
        }
    }

    func onCancel() {
        lockManagerDelegate.onCancelUnlock()
        router.dismiss(didUnlock: false)
    }

    func onTapBiometric() {
        interactor.biometricUnlock()
    }

}

extension UnlockPinPresenter: IUnlockPinInteractorDelegate {

    func didBiometricUnlock() {
        lockManagerDelegate.onUnlock()
        router.dismiss(didUnlock: true)
    }

    func didFailBiometricUnlock() {
    }

    func update(lockoutState: LockoutState) {
        switch lockoutState {
        case .unlocked(let attemptsLeft):
            view?.show(attemptsLeft: attemptsLeft, forPage: Page.unlock.rawValue)
        case .locked(let dueDate):
            view?.showLockView(till: dueDate)
        }
    }

}
