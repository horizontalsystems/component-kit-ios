import UIKit

class BaseCurrencySettingsRouter {
    weak var viewController: UIViewController?
}

extension BaseCurrencySettingsRouter: IBaseCurrencySettingsRouter {

    func dismiss() {
        if let navigationController = viewController?.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            viewController?.dismiss(animated: true)
        }
    }

}

extension BaseCurrencySettingsRouter {

    static func module(currencyManager: CurrencyManager) -> UIViewController {
        let router = BaseCurrencySettingsRouter()
        let interactor = BaseCurrencySettingsInteractor(currencyManager: currencyManager)
        let presenter = BaseCurrencySettingsPresenter(router: router, interactor: interactor)
        let view = BaseCurrencySettingsViewController(delegate: presenter)

        presenter.view = view
        router.viewController = view

        return view
    }

}
