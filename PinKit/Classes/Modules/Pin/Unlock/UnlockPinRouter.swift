import UIKit
import StorageKit

class UnlockPinRouter {
    weak var viewController: UIViewController?

    private let delegate: IUnlockDelegate
    private let autoDismiss: Bool

    init(delegate: IUnlockDelegate, autoDismiss: Bool) {
        self.delegate = delegate
        self.autoDismiss = autoDismiss
    }

}

extension UnlockPinRouter: IUnlockPinRouter {

    func dismiss(didUnlock: Bool) {
        if autoDismiss {
            viewController?.dismiss(animated: true)
        }

        if didUnlock {
            delegate.onUnlock()
        } else {
            delegate.onCancelUnlock()
        }
    }

}

extension UnlockPinRouter {

    static func module(delegate: IUnlockDelegate, lockManagerDelegate: IUnlockDelegate, pinManager: IPinManager, lockoutManager: ILockoutManager, biometryUnlockMode: BiometryUnlockMode, insets: UIEdgeInsets, cancellable: Bool = true, autoDismiss: Bool = true, biometryManager: IBiometryManager) -> UIViewController {
        let biometricManager = BiometricManager()
        let timer = OneTimeTimer()

        let router = UnlockPinRouter(delegate: delegate, autoDismiss: autoDismiss)
        let interactor = UnlockPinInteractor(pinManager: pinManager, biometricManager: biometricManager, lockoutManager: lockoutManager, timer: timer, biometryManager: biometryManager)
        let presenter = UnlockPinPresenter(interactor: interactor, router: router, lockManagerDelegate: lockManagerDelegate, configuration: .init(cancellable: cancellable, biometryUnlockMode: biometryUnlockMode))

        let viewController = PinViewController(delegate: presenter, insets: insets)

        biometricManager.delegate = interactor
        interactor.delegate = presenter
        presenter.view = viewController
        router.viewController = viewController

        viewController.modalPresentationStyle = .fullScreen

        return viewController
    }

}
