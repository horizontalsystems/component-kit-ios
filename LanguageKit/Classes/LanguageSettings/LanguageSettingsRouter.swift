import UIKit

public class LanguageSettingsRouter {
    weak var viewController: UIViewController?

    private let mainModuleCreator: () -> UIViewController

    init(mainModuleCreator: @escaping () -> UIViewController) {
        self.mainModuleCreator = mainModuleCreator
    }

}

extension LanguageSettingsRouter: ILanguageSettingsRouter {

    func dismiss() {
        if let navigationController = viewController?.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            viewController?.dismiss(animated: true)
        }
    }

    func reloadAppInterface() {
        UIApplication.shared.keyWindow?.set(newRootController: mainModuleCreator())
    }

}

extension LanguageSettingsRouter {

    public static func module(mainModuleCreator: @escaping () -> UIViewController) -> UIViewController {
        let router = LanguageSettingsRouter(mainModuleCreator: mainModuleCreator)
        let interactor = LanguageSettingsInteractor()
        let presenter = LanguageSettingsPresenter(router: router, interactor: interactor)
        let view = LanguageSettingsViewController(delegate: presenter)

        presenter.view = view
        router.viewController = view

        return view
    }

}
