import UIKit
import StorageKit

class UnlockPinRouter {
    weak var viewController: UIViewController?

    private let delegate: IUnlockDelegate

    init(delegate: IUnlockDelegate) {
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

        viewController?.dismiss(animated: false)
    }

}

extension UnlockPinRouter {

    static func module(delegate: IUnlockDelegate, lockManagerDelegate: IUnlockDelegate, pinManager: IPinManager, lockoutManager: ILockoutManager, enableBiometry: Bool, autoBiometry: Bool, insets: UIEdgeInsets, cancellable: Bool = true) -> UIViewController {
        let biometricManager = BiometricManager()
        let timer = OneTimeTimer()

        let router = UnlockPinRouter(delegate: delegate)
        let interactor = UnlockPinInteractor(pinManager: pinManager, biometricManager: biometricManager, lockoutManager: lockoutManager, timer: timer)
        let presenter = UnlockPinPresenter(interactor: interactor, router: router, lockManagerDelegate: lockManagerDelegate, configuration: .init(cancellable: cancellable, enableBiometry: enableBiometry, autoBiometry: autoBiometry))

        let viewController = PinViewController(delegate: presenter, enableBiometry: enableBiometry, insets: insets)

        biometricManager.delegate = interactor
        interactor.delegate = presenter
        presenter.view = viewController
        router.viewController = viewController

        viewController.modalTransitionStyle = .crossDissolve

        return viewController
    }

}
