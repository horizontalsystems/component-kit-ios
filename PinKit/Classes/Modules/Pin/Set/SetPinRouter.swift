import UIKit
import ThemeKit

public class SetPinRouter {
    weak var viewController: UIViewController?

    private let delegate: ISetPinDelegate

    init(delegate: ISetPinDelegate) {
        self.delegate = delegate
    }

}

extension SetPinRouter: ISetPinRouter {

    func notifyCancelled() {
        delegate.didCancelSetPin()
    }

    func close() {
        viewController?.dismiss(animated: true)
    }

}

extension SetPinRouter {

    static func module(delegate: ISetPinDelegate, pinManager: IPinManager) -> UIViewController {
        let router = SetPinRouter(delegate: delegate)
        let interactor = PinInteractor(pinManager: pinManager)
        let presenter = SetPinPresenter(interactor: interactor, router: router)
        let viewController = PinViewController(delegate: presenter)

        interactor.delegate = presenter
        presenter.view = viewController
        router.viewController = viewController

        let navigationController = ThemeNavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }

}
