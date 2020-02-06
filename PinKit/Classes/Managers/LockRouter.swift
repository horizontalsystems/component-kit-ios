import UIKit

class LockRouter: ILockRouter {

    func showUnlock(delegate: IUnlockDelegate, lockProvider: ILockProvider) {
        var controller = lockProvider.viewController

        while let presentedController = controller?.presentedViewController {
            controller = presentedController
        }

        controller?.present(lockProvider.lockScreenModule(delegate: delegate, appStart: false), animated: true)
    }

}
