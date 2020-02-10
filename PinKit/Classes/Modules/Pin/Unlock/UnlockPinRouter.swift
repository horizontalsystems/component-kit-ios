import UIKit
import StorageKit

class UnlockPinRouter {
    weak var viewController: UIViewController?

    private let delegate: IUnlockDelegate

    private let unlockMode: PresentationStyle

    init(unlockMode: PresentationStyle, delegate: IUnlockDelegate) {
        self.unlockMode = unlockMode
        self.delegate = delegate
    }

}

extension UnlockPinRouter: IUnlockPinRouter {

    func dismiss(didUnlock: Bool) {
        if didUnlock {
            delegate.onUnlock()
        } else {
            delegate.onCancelUnlock()
        }

        if unlockMode == .simple {
            viewController?.dismiss(animated: false)
        }
    }

}

extension UnlockPinRouter {

    static func module(delegate: IUnlockDelegate, lockManagerDelegate: IUnlockDelegate, pinManager: IPinManager, lockoutManager: ILockoutManager, enableBiometry: Bool, presentationStyle: PresentationStyle, cancellable: Bool = true) -> UIViewController {
        let biometricManager = BiometricManager()
        let timer = OneTimeTimer()

        let router = UnlockPinRouter(unlockMode: presentationStyle, delegate: delegate)
        let interactor = UnlockPinInteractor(pinManager: pinManager, biometricManager: biometricManager, lockoutManager: lockoutManager, timer: timer)
        let presenter = UnlockPinPresenter(interactor: interactor, router: router, lockManagerDelegate: lockManagerDelegate, configuration: .init(cancellable: cancellable, enableBiometry: enableBiometry))

        let viewController = PinViewController(delegate: presenter, presentationStyle: presentationStyle)

        biometricManager.delegate = interactor
        interactor.delegate = presenter
        presenter.view = viewController
        router.viewController = viewController

        viewController.modalTransitionStyle = .crossDissolve

        return viewController
    }

}
