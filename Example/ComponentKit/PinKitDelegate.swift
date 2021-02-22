import UIKit
import PinKit

class PinKitDelegate {
    var viewController: UIViewController?
}

extension PinKitDelegate: IPinKitDelegate {

    func onLock(delegate: IUnlockDelegate) {
        var controller = viewController

        while let presentedController = controller?.presentedViewController {
            controller = presentedController
        }

        controller?.present(App.shared.pinKit.unlockPinModule(delegate: delegate, biometryUnlockMode: .enabled, insets: .zero, cancellable: true, autoDismiss: true), animated: true)
    }

}
