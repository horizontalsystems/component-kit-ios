import UIKit
import ThemeKit

public class EditPinRouter {
    weak var viewController: UIViewController?
}

extension EditPinRouter: IEditPinRouter {

    func dismiss() {
        viewController?.dismiss(animated: true)
    }

}

extension EditPinRouter {

    public static func module(pinManager: IPinManager) -> UIViewController {
        let router = EditPinRouter()
        let interactor = PinInteractor(pinManager: pinManager)
        let presenter = EditPinPresenter(interactor: interactor, router: router)
        let controller = PinViewController(delegate: presenter)

        let navigationController = ThemeNavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .fullScreen

        interactor.delegate = presenter
        presenter.view = controller
        router.viewController = controller

        return navigationController
    }

}
