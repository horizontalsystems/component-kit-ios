import PinKit

class LockProvider {
    public var viewController: UIViewController?
}

extension LockProvider: ILockProvider {

    public func lockScreenModule(delegate: IUnlockDelegate, appStart: Bool) -> UIViewController {
        App.shared.pinKit.unlockPinModule(delegate: delegate, enableBiometry: true, unlockMode: .simple)
    }

}
